import 'package:app_uacheck_1/config/helpers/app_exception.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/domain/entities/course.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TeacherCoursesScreen extends ConsumerStatefulWidget {
  const TeacherCoursesScreen({super.key});

  @override
  ConsumerState<TeacherCoursesScreen> createState() =>
      _TeacherCoursesScreenState();
}

class _TeacherCoursesScreenState extends ConsumerState<TeacherCoursesScreen> {
  // Lo que el docente escribe en el buscador (en minúsculas)
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(teacherCoursesProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'UACheck'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mis Materias',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    setState(() => _query = value.trim().toLowerCase());
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cursos Registrados',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Ver calendario',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                coursesAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => _buildError(error),
                  data: (courses) => _buildList(courses),
                ),

                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 190,
                    child: CustomButton(
                      text: 'Añadir materia',
                      icon: Icons.add,
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      onPressed: () => context.push('/teacher/add-course'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(
        indexActual: 1,
        isTeacher: true,
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
          onPressed: () => ref.invalidate(teacherCoursesProvider),
          child: const Text('Reintentar'),
        ),
      ],
    );
  }

  Widget _buildList(List<Course> courses) {
    final filtered = courses.where((course) {
      return course.title.toLowerCase().contains(_query) ||
          course.code.toLowerCase().contains(_query);
    }).toList();

    if (filtered.isEmpty) {
      final message = courses.isEmpty
          ? 'Aún no tienes materias. Toca "Añadir materia" para crear la primera.'
          : 'No se encontraron materias con esa búsqueda.';
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (final course in filtered)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => context.push('/teacher/course-detail'),
              child: CourseCard(
                title: course.title,
                code: course.code,
                schedule: course.scheduleText,
                classroom: course.classroom,
                studentsCount: course.studentsCount,
              ),
            ),
          ),
      ],
    );
  }
}