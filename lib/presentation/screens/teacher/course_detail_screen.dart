import 'package:app_uacheck_1/config/helpers/app_exception.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/domain/entities/course.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CourseDetailScreen extends ConsumerWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(teacherCoursesProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detalle materia',
        showBackButton: true,
      ),
      body: SafeArea(
        child: coursesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              Center(child: Text(AppException.messageOf(error))),
          data: (courses) {
            // Busco la materia que corresponde al id de la ruta
            final matches = courses.where((course) => course.id == courseId);
            if (matches.isEmpty) {
              return const Center(child: Text('No se encontró la materia.'));
            }
            return _buildContent(context, matches.first);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Course course) {
    final headerLabel = course.code.isEmpty
        ? course.groupName
        : '${course.code} · ${course.groupName}';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headerLabel,
                          style: const TextStyle(
                            color: AppColors.primarySoft,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          course.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${course.scheduleText} · ${course.classroom} · '
                          '${course.studentsCount} inscritos',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.co_present, color: Colors.white70, size: 28),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Accesos rápidos',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),

            const SizedBox(height: 12),

            QuickActionTile(
              title: 'Generar código QR',
              icon: Icons.qr_code_2,
              onTap: () => context.push('/teacher/generate-qr'),
            ),

            QuickActionTile(
              title: 'Cargar listado (CSV)',
              subtitle: 'Importa o actualiza estudiantes',
              icon: Icons.file_upload_outlined,
              onTap: () => context.push('/teacher/course/$courseId/students'),
            ),

            QuickActionTile(
              title: 'Tomar asistencia',
              subtitle: 'Inicia una sesión con QR',
              icon: Icons.crop_free,
              onTap: () => context.push('/teacher/live-session'),
            ),

            QuickActionTile(
              title: 'Estadísticas',
              subtitle: 'Consulta rendimiento y tendencias',
              icon: Icons.show_chart,
              onTap: () => context.push('/teacher/stats'),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ÚLTIMA SESIÓN · 29 SEP',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '29 de 32 presentes',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '91%',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
