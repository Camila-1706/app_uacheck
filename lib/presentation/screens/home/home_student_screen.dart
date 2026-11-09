import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const CustomAppBar(title: 'Inicio Estudiante',),
              Text('FeCHA'),
              Text('HOLAAA'),
              Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary),

                child: Column(
                  children: [
                    const Text('PRÓXIMA SESIÓN'),
                    Text('CLASEEE PENDIENTE'),
                    Text('HORAA PENDIENTE'),
                    Container(
                      decoration: BoxDecoration(color: AppColors.primaryOnDark ),
                      child: Row(
                      children: [
                        Icon (Icons.arrow_circle_right),
                        Text('Iniciar toma de asistencia', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    )),
                    SizedBox(height: 15,),
                    Text('Resumen del día', style: TextStyle( color: AppColors.darkBackground, fontSize: 10, fontWeight: FontWeight.bold),),
                    Row(children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            

                          ],),)
                    ],)
                    

                  ],),)

          ]),
        ),
      ),
    );
  }
}
