import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/logo_uacheck.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Asistencia\nUniamazonia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    '¿Cómo deseas ingresar?',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                  SizedBox(height: 25),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.assignment_ind_outlined),
                    label: Text('Soy Docente'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      overlayColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.school),
                    label: Text('Soy Estudiante'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      overlayColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
