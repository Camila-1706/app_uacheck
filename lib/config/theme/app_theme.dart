import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Temas claro y oscuro de la app.
class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.background,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.primaryOnDark,
          onPrimary: Colors.white,
          surface: AppColors.darkSurface,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
      );
}
