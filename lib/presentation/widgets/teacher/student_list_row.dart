import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StudentListRow extends StatelessWidget {
  final String name;
  final String code;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const StudentListRow({
    super.key,
    required this.name,
    required this.code,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  code,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.successSoft,
              minimumSize: const Size(36, 36),
              padding: EdgeInsets.zero,
            ),
          ),

          const SizedBox(width: 8),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.danger,
              size: 18,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.dangerSoft,
              minimumSize: const Size(36, 36),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
