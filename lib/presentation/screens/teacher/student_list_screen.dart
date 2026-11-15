import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_section_header.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/student_list_row.dart';
import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Listado estudiantes',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Importa un archivo Excel o CSV',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.successSoft.withValues(alpha: 0.6),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.table_chart_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Subir Excel / CSV',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14),
                CustomButton(
                  text: 'Subir archivo',
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  icon: Icons.file_upload_outlined,
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                CustomSectionHeader(
                  title: 'Vista previa',
                  subtitle: 'Ultima actualizacion 7456464',
                  badgeText: '32 matriuclados',
                ),
                SizedBox(height: 17),

                Container(
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ESTUDIANTE',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ACCIONES',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 1, color: AppColors.border),

                      // Filas de estudiantes
                      StudentListRow(
                        name: 'María Fernanda fgh',
                        code: '7985623253',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      StudentListRow(
                        name: 'María Fernanda fgh',
                        code: '7985623253',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      StudentListRow(
                        name: 'María Fernanda fgh',
                        code: '7985623253',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      StudentListRow(
                        name: 'María Fernanda fgh',
                        code: '7985623253',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      StudentListRow(
                        name: 'María Fernanda fgh',
                        code: '7985623253',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                      const Divider(height: 1, color: AppColors.border),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: AboutDialog.new,
        child: Icon(Icons.add),
      ),
    );
  }
}
