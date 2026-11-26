import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:app_uacheck_1/domain/entities/user.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  CustomButton(
                    icon: Icons.assignment_ind_outlined,
                    text: 'Soy Docente',
                    isOutlined: true,
                    onPressed: () {
                      ref.read(selectedRoleProvider.notifier).state =
                          UserRole.teacher;
                      context.push('/login');
                    },
                  ),

                  SizedBox(height: 30),

                  CustomButton(
                    icon: Icons.school,
                    text: 'Soy Estudiante',
                    isOutlined: true,
                    onPressed: () {
                      ref.read(selectedRoleProvider.notifier).state =
                          UserRole.student;
                      context.push('/login');
                    },
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
