import 'package:app_uacheck_1/config/theme/app_colors.dart';

import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_attendance_student.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class StudentHistoryScreen extends StatefulWidget {
  const StudentHistoryScreen({super.key});

  @override
  State<StudentHistoryScreen> createState() => _StudentHistoryScreenState();
}

class _StudentHistoryScreenState extends State<StudentHistoryScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Historial'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildFilterTab('Todas', 0),
                      _buildFilterTab('Este mes', 1),
                      _buildFilterTab('Por materia', 2),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCounter('64', 'Presentes', AppColors.primary),
                      _buildCounter('4', 'Tardes', AppColors.warning),
                      _buildCounter('2', 'Ausencias', AppColors.danger),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                Text(
                  'Registro cronológico',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 12),

                const AttendanceStudent(
                  day: '01',
                  month: 'OCT',
                  name: 'Ingeniería de Software',
                  subtitle: 'Sesión 10 · 10:03 a. m.',
                  estado: 'Presente',
                ),
                const AttendanceStudent(
                  day: '30',
                  month: 'SEP',
                  name: 'Bases de Datos II',
                  subtitle: 'Sesión 9 · 2:08 p. m.',
                  estado: 'Presente',
                ),
                const AttendanceStudent(
                  day: '29',
                  month: 'SEP',
                  name: 'Redes de Computadores',
                  subtitle: 'Sesión 8 · 8:16 a. m.',
                  estado: 'Tarde',
                ),
                const AttendanceStudent(
                  day: '26',
                  month: 'SEP',
                  name: 'Matemáticas Discretas',
                  subtitle: 'Sesión 7 · sin registro',
                  estado: 'Ausente',
                ),
                const AttendanceStudent(
                  day: '22',
                  month: 'SEP',
                  name: 'Ingeniería de Software',
                  subtitle: 'Sesión 9 · 10:01 a. m.',
                  estado: 'Presente',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(indexActual: 2),
    );
  }

  Widget _buildFilterTab(String label, int index) {
    final bool isSelected = _selectedFilter == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildCounter(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}