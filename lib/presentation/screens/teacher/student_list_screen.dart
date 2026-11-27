import 'package:app_uacheck_1/config/helpers/app_exception.dart';
import 'package:app_uacheck_1/config/helpers/context_extensions.dart';
import 'package:app_uacheck_1/config/helpers/csv_helper.dart';
import 'package:app_uacheck_1/config/helpers/student_import_helper.dart';
import 'package:app_uacheck_1/config/helpers/validators.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/domain/entities/enrolled_student.dart';
import 'package:app_uacheck_1/domain/entities/imported_student.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_section_header.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/import_summary.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/student_list_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentListScreen extends ConsumerStatefulWidget {
  final String courseId;

  const StudentListScreen({super.key, required this.courseId});

  @override
  ConsumerState<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends ConsumerState<StudentListScreen> {
  StudentImportResult? _importResult; // archivo elegido, aún sin cargar
  bool _uploading = false;

  // Vuelve a pedir la lista y el contador de la materia
  void _refreshData() {
    ref.invalidate(courseStudentsProvider(widget.courseId));
    ref.invalidate(teacherCoursesProvider);
  }

  Future<void> _pickFile() async {
    try {
      final result = await StudentImportHelper.pickAndParse();
      if (result == null) return;
      if (!mounted) return;
      setState(() => _importResult = result);
    } catch (e) {
      if (mounted) context.showMessage(AppException.messageOf(e), error: true);
    }
  }

  Future<void> _uploadStudents() async {
    final importResult = _importResult;
    if (importResult == null) return;

    setState(() => _uploading = true);

    try {
      final enrollResult = await ref
          .read(courseRepositoryProvider)
          .enrollStudents(
            courseId: widget.courseId,
            students: importResult.students,
          );

      _refreshData();
      if (!mounted) return;

      setState(() => _importResult = null);
      context.showMessage(
        'Listado cargado: ${enrollResult.added} nuevos, '
        '${enrollResult.updated} ya estaban (actualizados)',
      );
    } catch (e) {
      if (mounted) context.showMessage(AppException.messageOf(e), error: true);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  // Sirve para añadir (studentToEdit == null) y para editar el nombre
  Future<void> _showStudentDialog({EnrolledStudent? studentToEdit}) async {
    final isEditing = studentToEdit != null;
    final codeController = TextEditingController(
      text: studentToEdit?.code ?? '',
    );
    final nameController = TextEditingController(
      text: studentToEdit?.name ?? '',
    );

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        scrollable: true,
        title: Text(isEditing ? 'Editar estudiante' : 'Añadir estudiante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              enabled: !isEditing, // el código no se cambia, es la llave
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Código'),
            ),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nombre completo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    final studentCode = codeController.text.trim();
    final studentName = nameController.text.trim().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );

    if (confirmed != true || !mounted) return;

    final codeError = Validators.userCode(studentCode);
    if (codeError != null) {
      context.showMessage(codeError, error: true);
      return;
    }
    if (studentName.isEmpty) {
      context.showMessage('Escribe el nombre del estudiante', error: true);
      return;
    }

    // Reutilizo enrollStudents con un solo estudiante (si ya existe, actualiza el nombre)
    try {
      await ref
          .read(courseRepositoryProvider)
          .enrollStudents(
            courseId: widget.courseId,
            students: [ImportedStudent(code: studentCode, name: studentName)],
          );
      _refreshData();
      if (mounted) {
        context.showMessage(
          isEditing ? 'Estudiante actualizado' : 'Estudiante guardado',
        );
      }
    } catch (e) {
      if (mounted) context.showMessage(AppException.messageOf(e), error: true);
    }
  }

  Future<void> _deleteStudent(EnrolledStudent student) async {
    final displayName = student.name.isEmpty ? student.code : student.name;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Quitar estudiante'),
        content: Text(
          '¿Quitar a $displayName de esta materia? '
          'Podrás volver a añadirlo después.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Quitar'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await ref
          .read(courseRepositoryProvider)
          .removeStudent(courseId: widget.courseId, studentCode: student.code);
      _refreshData();
      if (mounted) context.showMessage('Estudiante quitado de la materia');
    } catch (e) {
      if (mounted) context.showMessage(AppException.messageOf(e), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(courseStudentsProvider(widget.courseId));

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Listado estudiantes',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Importa un archivo CSV (guardado desde Excel)',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: _pickFile,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.successSoft.withValues(alpha: 0.6),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.table_chart_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _importResult == null
                              ? 'Elegir archivo CSV'
                              : 'Cambiar archivo',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_importResult != null) ...[
                  const SizedBox(height: 10),
                  Center(child: ImportSummary(result: _importResult!)),
                ],
                const SizedBox(height: 14),
                CustomButton(
                  text: _importResult == null
                      ? 'Subir archivo'
                      : 'Cargar ${_importResult!.students.length} estudiantes',
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  icon: Icons.file_upload_outlined,
                  isLoading: _uploading,
                  onPressed: (_importResult == null || _uploading)
                      ? null
                      : _uploadStudents,
                ),
                const SizedBox(height: 20),
                studentsAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => _buildError(error),
                  data: (students) => _buildStudentsSection(students),
                ),
                const SizedBox(
                  height: 80,
                ), // espacio para que el + no tape la última fila
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => _showStudentDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildError(Object error) {
    return Column(
      children: [
        Text(
          AppException.messageOf(error),
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.danger),
        ),
        TextButton(
          onPressed: () =>
              ref.invalidate(courseStudentsProvider(widget.courseId)),
          child: const Text('Reintentar'),
        ),
      ],
    );
  }

  Widget _buildStudentsSection(List<EnrolledStudent> students) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSectionHeader(
          title: 'Estudiantes matriculados',
          subtitle: 'Quienes no se han registrado aparecen con una nota',
          badgeText: '${students.length} matriculados',
        ),
        const SizedBox(height: 17),
        if (students.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'Aún no hay estudiantes. Sube un CSV o toca + para añadir uno.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ESTUDIANTE',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ACCIONES',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
                for (final student in students) ...[
                  StudentListRow(
                    name: student.name.isEmpty ? 'Sin nombre' : student.name,
                    code: student.hasAccount
                        ? student.code
                        : '${student.code} · Sin cuenta aún',
                    onEdit: () => _showStudentDialog(studentToEdit: student),
                    onDelete: () => _deleteStudent(student),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
