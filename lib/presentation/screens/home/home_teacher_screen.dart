import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/schedule_title.dart';
import 'package:app_uacheck_1/presentation/widgets/teacher/summary_card.dart';
import 'package:flutter/material.dart';

class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        trailing: CircleAvatar(
          child: Text('AM'),
          backgroundColor: AppColors.primaryOnDark,
          foregroundColor: AppColors.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FeCHA',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  'HOLAAA',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
        
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PRÓXIMA SESIÓN',
                        style: TextStyle(
                          color: AppColors.primarySoft,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.0,
                        ),
                      ),
                      Text(
                        'CLASEEE PENDIENTE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.primarySoft,
                          ),
                          Text(
                            'HORAA PENDIENTE',
                            style: TextStyle(
                              color: AppColors.primarySoft,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
        
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: AppColors.background,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.play_circle_fill),
                        label: Text('Iniciar toma de asistencia'),
                      ),
                    ],
                  ),
                ),
        
                SizedBox(height: 15),
                Text(
                  'Resumen del día',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        color: AppColors.primaryOnDark,
                        icono: Icons.calendar_today_outlined,
                        iconColor: AppColors.primaryDark,
                        descripcion: 'Clases hoy',
                        valor: '4',
                      ),
                    ),
                    SizedBox(width: 10),
        
                    Expanded(
                      child: SummaryCard(
                        color: AppColors.primaryOnDark,
                        icono: Icons.check_circle_outline_sharp,
                        iconColor: AppColors.primaryDark,
                        descripcion: 'Asistencia',
                        valor: '4',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SummaryCard(
                        color: AppColors.primaryOnDark,
                        icono: Icons.person_add_alt,
                        iconColor: AppColors.primaryDark,
                        descripcion: 'Alumnos',
                        valor: '4',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Cronograma de hoy'),
                SizedBox(height: 10),
                ScheduleTitle(
                  time: '8:00',
                  period: 'A.M',
                  location: 'Sala 7203',
                  nombreAsignatura: 'Ingeniería de software',
                ),
                ScheduleTitle(
                  time: '8:00',
                  period: 'A.M',
                  location: 'Sala 7203',
                  nombreAsignatura: 'Ingeniería de software',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
