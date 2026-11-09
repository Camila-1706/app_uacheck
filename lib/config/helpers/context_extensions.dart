import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

extension ThemeX on BuildContext {
  ColorScheme get scheme => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get surfaceColor => scheme.surface;
  Color get brandColor => scheme.primary;
  Color get mutedColor =>
      isDark ? const Color(0xFF9DB0A5) : AppColors.textMuted;
  Color get borderColor =>
      isDark ? const Color(0xFF2A3A31) : AppColors.border;
  Color get softBrandColor =>
      isDark ? const Color(0xFF223229) : AppColors.primarySoft;

  void showMessage(String text, {bool error = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(text),
        backgroundColor: error ? AppColors.danger : AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
      ));
  }
}
