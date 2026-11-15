import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttendanceStudent extends StatelessWidget {
  final String letter;
  final String name;
  final String subtitle;
  final String estado;

  const AttendanceStudent({
    super.key,
    required this.letter,
    required this.name,
    required this.subtitle,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    final Color badgeColor;
    final Color contentColor;
    final IconData estadoIcon;

    if (estado == 'Presente') {
      badgeColor = AppColors.successSoft;
      contentColor = AppColors.primary;
      estadoIcon = Icons.check_circle_outline;
    } else if (estado == 'Tarde') {
      badgeColor = AppColors.warningSoft;
      contentColor = AppColors.warning;
      estadoIcon = Icons.access_time;
    } else {
      badgeColor = AppColors.dangerSoft;
      contentColor = AppColors.danger;
      estadoIcon = Icons.cancel_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color.fromARGB(31, 44, 42, 42)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryOnDark,
            child: Text(letter),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(name), Text(subtitle)],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: badgeColor),
            child: Row(
              children: [
                Icon(estadoIcon, color: contentColor, size: 16,),
                SizedBox(width: 4.0),
                Text(
                  estado,
                  style: TextStyle(
                    color: contentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
