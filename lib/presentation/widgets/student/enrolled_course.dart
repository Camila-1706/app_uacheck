import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EnrolledCourse extends StatelessWidget {
  final String title;
  final String subtitle;
  final int percentage;
  final VoidCallback? onTap;

  const EnrolledCourse({
    super.key,
    required this.title,
    required this.subtitle,
    required this.percentage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWarning = percentage < 80;
    final Color mainColor = isWarning
        ? AppColors.warning
        : Theme.of(context).colorScheme.primary;
    final Color softColor = isWarning
        ? AppColors.warningSoft
        : AppColors.successSoft;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: softColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.menu_book_outlined,
                      color: mainColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
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
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: AppColors.background,
                  color: mainColor,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
