import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badgeText;

  const CustomSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: AppColors.textMuted),
              ),
            ],
          ),
        ),
        if (badgeText != null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: AppColors.successSoft,
            ),
            padding: EdgeInsets.all(7.0),
            child: Text(
              badgeText!,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
