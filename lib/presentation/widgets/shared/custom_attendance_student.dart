import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttendanceStudent extends StatelessWidget {
  final String? letter;
  final String? day;
  final String? month;
  final String name;
  final String subtitle;
  final String estado;

  const AttendanceStudent({
    super.key,
    this.letter,
    this.day,
    this.month,
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          if (day != null && month != null)
            SizedBox(
              width: 38,
              child: Column(
                children: [
                  Text(
                    day!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    month!,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            )
          else
            CircleAvatar(
              backgroundColor: AppColors.primaryOnDark,
              child: Text(letter ?? ''),
            ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: badgeColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(estadoIcon, color: contentColor, size: 15),
                const SizedBox(width: 4.0),
                Text(
                  estado,
                  style: TextStyle(
                    color: contentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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