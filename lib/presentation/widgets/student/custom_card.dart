import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final Color color;
  final Icon icono;
  final String valor;
  final String descripcion;

  const CustomCard({super.key, required this.color, required this.icono, this.valor = '', required this.descripcion});


  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.primaryOnDark),
            child: Icon(Icons.calendar_today_outlined ),
            ),
            Text(valor),
            Text(descripcion),


      ],),


    );
  }
}