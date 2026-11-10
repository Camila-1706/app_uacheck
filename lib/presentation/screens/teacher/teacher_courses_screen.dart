import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/course_card.dart';
import 'package:flutter/material.dart';

class TeacherCoursesScreen extends StatelessWidget {
  const TeacherCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        trailing: CircleAvatar(
          child: Text('AM'),
          backgroundColor: AppColors.primaryOnDark,
          foregroundColor: AppColors.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mis Materias',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                SearchBar(),

                SizedBox(height: 12),
                Text(
                  'Cursos Registrados',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),

                CourseCard(
                  title: 'adsdsd',
                  code: '5353456',
                  schedule: 'aferesfs',
                  classroom: 'clssa',
                  studentsCount: 23,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                CourseCard(
                  title: 'adsdsd',
                  code: '5353456',
                  schedule: 'aferesfs',
                  classroom: 'clssa',
                  studentsCount: 23,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Añadir materia'),
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: CustomBottomNavigation(indexActual: 1),
    );
  }
}
