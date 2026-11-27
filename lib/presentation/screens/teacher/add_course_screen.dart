import 'package:app_uacheck_1/config/helpers/app_exception.dart';
import 'package:app_uacheck_1/config/helpers/context_extensions.dart';
import 'package:app_uacheck_1/config/helpers/validators.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_uacheck_1/config/helpers/csv_helper.dart';
import 'package:app_uacheck_1/config/helpers/student_import_helper.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/import_summary.dart';

class AddCourseScreen extends ConsumerStatefulWidget {
  const AddCourseScreen({super.key});

  @override
  ConsumerState<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends ConsumerState<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _groupController = TextEditingController();
  final _classroomController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();

  final Set<int> _selectedDays = {};

  static const _dayLabels = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  bool _saving = false;
  StudentImportResult? _importResult;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _groupController.dispose();
    _classroomController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked == null) return;

    final hour = picked.hour.toString().padLeft(2, '0');
    final minute = picked.minute.toString().padLeft(2, '0');
    controller.text = '$hour:$minute';
  }

  Future<void> _pickCsv() async {
    try {
      final result = await StudentImportHelper.pickAndParse();
      if (result == null) return;

      if (!mounted) return;
      setState(() => _importResult = result);
    } catch (e) {
      if (mounted) context.showMessage(AppException.messageOf(e), error: true);
    }
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDays.isEmpty) {
      context.showMessage('Selecciona al menos un día de clase', error: true);
      return;
    }

    setState(() => _saving = true);

    try {
      final repo = ref.read(courseRepositoryProvider);
      final days = _selectedDays.toList()..sort();

      final courseId = await repo.createCourse(
        name: _nameController.text,
        code: _codeController.text,
        groupName: _groupController.text,
        classroom: _classroomController.text,
        days: days,
        startTime: _startController.text,
        endTime: _endController.text,
      );

      var message = 'Materia guardada';
      final students = _importResult?.students ?? [];

      if (students.isNotEmpty) {
        try {
          final result = await repo.enrollStudents(
            courseId: courseId,
            students: students,
          );
          message = 'Materia guardada con ${result.total} estudiantes';
        } catch (e) {
          // La materia ya existe; solo falló la carga de estudiantes
          message =
              'Materia guardada, pero no se pudieron cargar los '
              'estudiantes: ${AppException.messageOf(e)}';
        }
      }

      ref.invalidate(teacherCoursesProvider);

      if (!mounted) return;
      context.showMessage(message);
      context.pop();
    } catch (e) {
      if (mounted) context.showMessage(AppException.messageOf(e), error: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Añadir Materia', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _nameController,
                    label: 'Nombre',
                    hintText: 'Nombre de la materia',
                    prefixIcon: Icons.menu_book_outlined,
                    validator: (v) => Validators.required(v, 'El nombre'),
                  ),

                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _startController,
                          label: 'Hora Inicio',
                          hintText: '08:00',
                          prefixIcon: Icons.access_time,
                          readOnly: true,
                          onTap: () => _pickTime(_startController),
                          validator: (v) => Validators.required(v, 'La hora'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: _endController,
                          label: 'Hora fin',
                          hintText: '09:30',
                          prefixIcon: Icons.access_time,
                          readOnly: true,
                          onTap: () => _pickTime(_endController),
                          validator: (v) => Validators.required(v, 'La hora'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _groupController,
                          label: 'Grupo',
                          hintText: 'Ej. GR1',
                          prefixIcon: Icons.people_outlined,
                          validator: Validators.group,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: _codeController,
                          label: 'Código (opcional)',
                          hintText: 'Ej. ISW-601',
                          prefixIcon: Icons.tag,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  CustomTextField(
                    controller: _classroomController,
                    label: 'Aula',
                    hintText: 'Ej. B-204',
                    prefixIcon: Icons.home_outlined,
                    validator: (v) => Validators.required(v, 'El aula'),
                  ),

                  const SizedBox(height: 14),
                  Text(
                    'Días de clase',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (var i = 0; i < _dayLabels.length; i++)
                        FilterChip(
                          label: Text(_dayLabels[i]),
                          // El día número es i + 1 (lunes = 1)
                          selected: _selectedDays.contains(i + 1),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDays.add(i + 1);
                              } else {
                                _selectedDays.remove(i + 1);
                              }
                            });
                          },
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cargar estudiantes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          '${_importResult?.students.length ?? 0} estudiantes cargados',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.background,
                          child: Icon(
                            Icons.file_upload_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Sube el archivo institucional para vincular de\nforma inmediata a los cursantes.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          icon: Icons.menu_book_outlined,
                          text: _importResult == null
                              ? 'Subir CSV'
                              : 'Cambiar archivo',
                          isOutlined: true,
                          onPressed: _pickCsv,
                        ),
                        if (_importResult != null) ...[
                          const SizedBox(height: 8),
                          ImportSummary(result: _importResult!),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomButton(
                    icon: Icons.add,
                    text: _saving ? 'Guardando...' : 'Guardar materia',
                    isLoading: _saving,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    onPressed: _saving ? null : _save,
                  ),

                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        'Cancelar y volver',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
