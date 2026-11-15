import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Inicio Estudiante'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Buen día,', style: TextStyle(color: AppColors.textMuted)),
                Text(
                  'Alan Brito Delgado',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryDark,
                  ),

                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: 0.91,
                            strokeWidth: 7,
                            color: AppColors.success,
                            backgroundColor: Colors.greenAccent,
                          ),
                          Text('91%'),
                        ],
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ASISTENCIA GENERAL'),
                          Text('¡Vas muy bien este semestre!'),
                          Text('64 presentes de 70'),

                        
                        ],)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(indexActual: 0),
    );
  }
}
