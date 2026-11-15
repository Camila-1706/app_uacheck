import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_text_field.dart';
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
                  const CustomTextField(
                    label: 'Nombre',
                    hintText: 'Nombre de la materia',
                    prefixIcon: Icons.menu_book_outlined,
                  ),

                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Hora Inicio',
                          hintText: '08:00',
                          prefixIcon: Icons.menu_book_outlined,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          label: 'Hora fin',
                          hintText: '09:30',
                          prefixIcon: Icons.menu_book_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Grupo',
                          hintText: 'Ej. GR1',
                          prefixIcon: Icons.people_outlined,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cargar estudiantes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Text(
                          '0 estudiantes cargados',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.background,
                          child: Icon(
                            Icons.file_upload_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Sube el archivo institucional para vincular de\nforma inmediata a los cursantes.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          icon: Icons.menu_book_outlined,
                          text: 'Subir CSV',
                          isOutlined: true,
                          onPressed: () {},
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomButton(
                    icon: Icons.add,
                    text: 'Guardar materia',
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    onPressed: () {},
                  ),

                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar y volver',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
