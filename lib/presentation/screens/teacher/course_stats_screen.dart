import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';

class CourseStatsScreen extends StatefulWidget {
  const CourseStatsScreen({super.key});

  @override
  State<CourseStatsScreen> createState() => _CourseStatsScreenState();
}

class _CourseStatsScreenState extends State<CourseStatsScreen> {
  bool isExcelSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Estadísticas por materia',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.successSoft,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.menu_book_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURSO SELECCIONADO',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'Ingeniería de Software',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ISW722 - 32 estudiantes',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Formato de archivo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isExcelSelected = true;
                          });
                        },
                        icon: const Icon(Icons.table_chart_outlined, size: 18),
                        label: const Text('Excel (.xlsx)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isExcelSelected
                              ? Colors.white
                              : AppColors.background,
                          foregroundColor: isExcelSelected
                              ? AppColors.primary
                              : AppColors.textMuted,
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isExcelSelected = false;
                          });
                        },
                        icon: const Icon(Icons.description_outlined, size: 18),
                        label: const Text('CSV'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isExcelSelected
                              ? Colors.white
                              : AppColors.background,
                          foregroundColor: !isExcelSelected
                              ? AppColors.primary
                              : AppColors.textMuted,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                CustomButton(
                  text: isExcelSelected
                      ? 'Exportar reporte (Excel)'
                      : 'Exportar reporte (CSV)',
                  icon: Icons.file_download_outlined,
                  isOutlined: true,
                  onPressed: () {},
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Asistencia',
                        value: '91%',
                        detail: '7224',
                        detailColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Inasistencia',
                        value: '6%',
                        detail: '4727524',
                        detailColor: AppColors.danger,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Retardos',
                        value: '3%',
                        detail: '7 registros',
                        detailColor: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Asistencia por sesión',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Últimas 6',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBar('02 sep.', 55),
                          _buildBar('23', 85),
                          _buildBar('30', 100, isHighlighted: true),
                          _buildBar('07 oct.', 80),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Distribución del semestre',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'sesiones',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildProgressRow(
                        label: 'Presentes',
                        count: '5242',
                        progress: 0.85,
                        color: AppColors.primaryDark,
                      ),
                      const SizedBox(height: 12),
                      _buildProgressRow(
                        label: 'Inasistencias',
                        count: '4',
                        progress: 0.15,
                        color: AppColors.danger,
                      ),
                      const SizedBox(height: 12),
                      _buildProgressRow(
                        label: 'Retardos',
                        count: '10',
                        progress: 0.08,
                        color: AppColors.warning,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Datos consolidados hasta el ',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(
        indexActual: 2,
        isTeacher: true,
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String detail,
    required Color detailColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: TextStyle(
              color: detailColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double height, {bool isHighlighted = false}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: height,
          decoration: BoxDecoration(
            color: isHighlighted ? AppColors.primaryDark : AppColors.background,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildProgressRow({
    required String label,
    required String count,
    required double progress,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text(
              count,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.background,
          color: color,
          minHeight: 6,
        ),
      ],
    );
  }
}
