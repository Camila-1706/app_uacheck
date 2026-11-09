import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final Color color;
  final IconData icono;
  final String valor;
  final String descripcion;
  final Color iconColor;

  const SummaryCard({
    super.key,
    required this.color,
    required this.icono,
    required this.valor,
    required this.descripcion,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color
              ),
            child: Icon(icono, color: iconColor, size: 25,),
          ),
          SizedBox(height: 10),
          Text(
            valor,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(descripcion, style: TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
