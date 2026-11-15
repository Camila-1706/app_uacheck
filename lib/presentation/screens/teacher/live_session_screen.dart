import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_section_header.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/attendance_student.dart';
import 'package:flutter/material.dart';

class LiveSessionScreen extends StatelessWidget {
  const LiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sesión en vivo', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Container(width: double.infinity, color: Colors.black87),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'CÁMARA ACTIVA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Text(
                        'Centra el código QR dentro del marco',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSectionHeader(
                      title: 'Ingeniería de Software',
                      subtitle: 'Sesión 211.8754.26',
                      badgeText: '21 / 32',
                    ),

                    const SizedBox(height: 16),

                    const AttendanceStudent(
                      letter: 'V',
                      name: 'Valentina Rodríguez',
                      subtitle: '72758257527 - 45:21',
                      estado: 'Presente',
                    ),
                    const AttendanceStudent(
                      letter: 'V',
                      name: 'Valentina Rodríguez',
                      subtitle: '72758257527 - 45:21',
                      estado: 'Presente',
                    ),

                    const AttendanceStudent(
                      letter: 'V',
                      name: 'Valentina Rodríguez',
                      subtitle: '72758257527 - 45:21',
                      estado: 'Presente',
                    ),

                    const AttendanceStudent(
                      letter: 'V',
                      name: 'Valentina Rodríguez',
                      subtitle: '72758257527 - 45:21',
                      estado: 'Presente',
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: CustomButton(
          text: 'Finalizar sesión',
          icon: Icons.crop_square,
          backgroundColor: AppColors.danger,
          foregroundColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
