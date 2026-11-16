import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/course_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherCoursesScreen extends StatelessWidget {
  const TeacherCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                GestureDetector(
                  onTap: () => context.push('/teacher/course-detail'),
                  child: const CourseCard(
                    title: 'Ingeniería de Software - GR1',
                    code: 'ISW-601',
                    schedule: 'Mar/Jue 10:00',
                    classroom: 'B-204',
                    studentsCount: 32,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.push('/teacher/course-detail'),
                  child: const CourseCard(
                    title: 'Bases de Datos II - GR2',
                    code: 'BD-502',
                    schedule: 'Lun/Mié 14:00',
                    classroom: 'A-105',
                    studentsCount: 28,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.push('/teacher/course-detail'),
                  child: const CourseCard(
                    title: 'Proyecto de Grado',
                    code: 'PG-901',
                    schedule: 'Viernes 08:00',
                    classroom: 'Lab 3',
                    studentsCount: 18,
                  ),
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
      bottomNavigationBar: const CustomBottomNavigation(indexActual: 1, isTeacher: true,),
    );
  }
}
