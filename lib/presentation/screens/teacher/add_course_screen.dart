import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Añadir Materia', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre de la materia',
                      hintStyle: const TextStyle(color: AppColors.textMuted),
                      prefixIcon: const Icon(
                        Icons.menu_book_outlined,
                        color: AppColors.textMuted,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hora inicio',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hora fin',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8,),
                            TextFormField(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  const Text('Grupo',style: TextStyle(fontWeight: FontWeight.bold), )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
