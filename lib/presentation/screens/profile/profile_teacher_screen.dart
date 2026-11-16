import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_profile_settings.dart';
import 'package:flutter/material.dart';

class ProfileTeacherScreen extends StatelessWidget {
  const ProfileTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Mi perfil'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Cuenta Docente',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.textMuted, fontSize: 13,),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: AppColors.successSoft,
                        child: Icon(Icons.person, size: 40),
                      ),
                      Text(
                        'Nombre',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Correo @udla,seodfg',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColors.successSoft,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            Text(
                              'DOCENTE - HUDFKASDLAALD',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 32, color: AppColors.border),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          General(valor: 3, descricpion: 'Materias'),
                          General(valor: 3, descricpion: 'Materias'),
                          General(valor: 3, descricpion: 'Materias'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                const CustomProfileSettings(),


              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(indexActual: 3),
    );
  }
}

class General extends StatelessWidget {
  final int valor;
  final String descricpion;

  const General({super.key, required this.valor, required this.descricpion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$valor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          descricpion,
          style: TextStyle(fontSize: 18, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
