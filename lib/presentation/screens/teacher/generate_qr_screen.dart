import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_section_header.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_attendance_student.dart';
import 'package:flutter/material.dart';

class GenerateQrScreen extends StatelessWidget {
  const GenerateQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Generar QR', showBackButton: true),
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.successSoft,
                          child: Icon(
                            Icons.timer_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ciclo de validez',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '02:46',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text(
                        'Regenerar',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background,
                        foregroundColor: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: AppColors.border,
                    color: Theme.of(context).colorScheme.primary,
                    minHeight: 6,
                  ),
                ),
                SizedBox(height: 12),

                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey,
                    ),
                    height: 240,
                    width: 240,
                    padding: EdgeInsets.all(30),
                    child: Text('QR'),
                  ),
                ),

                const SizedBox(height: 12),
                const CustomSectionHeader(
                  title: 'Registros',
                  subtitle: 'adjajsksd -10msd',
                  badgeText: '21/54',
                ),

                const SizedBox(height: 12),

                AttendanceStudent(
                  letter: 'C',
                  name: 'Camdjsila',
                  subtitle: '12235346363 -33:232',
                  estado: 'Presente',
                ),
                AttendanceStudent(
                  letter: 'C',
                  name: 'Camdjsila',
                  subtitle: '12235346363 -33:232',
                  estado: 'Presente',
                ),
                AttendanceStudent(
                  letter: 'C',
                  name: 'Camdjsila',
                  subtitle: '12235346363 -33:232',
                  estado: 'Presente',
                ),
                AttendanceStudent(
                  letter: 'C',
                  name: 'Camdjsila',
                  subtitle: '12235346363 -33:232',
                  estado: 'Presente',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: CustomButton(
          icon: Icons.rectangle_outlined,
          text: 'Finalizar sesión',
          backgroundColor: AppColors.danger,
          foregroundColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
