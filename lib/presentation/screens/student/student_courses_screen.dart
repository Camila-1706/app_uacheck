import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentCoursesScreen extends StatelessWidget {
  const StudentCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Clases'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tus Materias de Hoy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Text(
                      'Miércoles, 24 Oct',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingeniería de Software - GR1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Row(
                        children: [
                          Icon(
                            Icons.co_present_outlined,
                            color: AppColors.textMuted,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Prof. Roberto Gómez',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.watch_later_outlined,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Horario',
                                  style: TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '10:00 - 12:00',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'Escanear QR de la clase',
                        icon: Icons.qr_code_scanner,
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        onPressed: () => context.push('/student/scan-qr'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                _buildClassItem(
                  context: context,
                  hour: '10',
                  period: '00 AM',
                  title: 'Ingeniería de Software',
                  subtitle: 'Aula C-204 • Docente: Gómez R.',
                  isCurrent: true,
                ),
                _buildClassItem(
                  context: context,
                  hour: '02',
                  period: '00 PM',
                  title: 'Bases de Datos II',
                  subtitle: 'Lab L-03 • Docente: Morales A.',
                ),
                _buildClassItem(
                  context: context,
                  hour: '04',
                  period: '00 PM',
                  title: 'Ética Profesional',
                  subtitle: 'Aula B-101 • Docente: Duarte V.',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(indexActual: 1),
    );
  }

  Widget _buildClassItem({
    required BuildContext context,
    required String hour,
    required String period,
    required String title,
    required String subtitle,
    bool isCurrent = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isCurrent ? AppColors.successSoft : AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  hour,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCurrent
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isCurrent ? AppColors.primary : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
