import 'package:app_uacheck_1/config/helpers/csv_helper.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImportSummary extends StatelessWidget {
  final StudentImportResult result;

  const ImportSummary({super.key, required this.result});

  void _showProblems(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Filas con problemas'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Estas filas se omitieron. Corrígelas en el archivo y vuelve '
                'a subirlo si las necesitas.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 12),
              for (final problem in result.problems)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(problem, style: const TextStyle(fontSize: 13)),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          result.fileName,
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          '${result.students.length} estudiantes válidos',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.success,
          ),
        ),
        if (result.problems.isNotEmpty)
          TextButton(
            onPressed: () => _showProblems(context),
            child: Text(
              '${result.problems.length} filas con problemas · Ver detalle',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.warning,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}