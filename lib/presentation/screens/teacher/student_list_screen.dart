import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_button.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_section_header.dart';
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
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Importa un archivo Excel o CSV',
                  style: TextStyle(color: AppColors.textMuted),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.successSoft,
                    border: Border.all(color: AppColors.primary),
                  ),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.table_chart_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'Subir Excel / CSV',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Subir archivo',
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  icon: Icons.file_upload_outlined,
                  onPressed: () {},
                ),
                SizedBox(height: 12),
                CustomSectionHeader(
                  title: 'Vista previa',
                  subtitle: 'Ultima actualizacion 7456464',
                  badgeText: '32 matriuclados',
                ),

                Container(
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ESTUDIANTE',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'ACCIONES',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
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
