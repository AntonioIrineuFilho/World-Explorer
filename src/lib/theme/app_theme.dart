import 'package:flutter/material.dart';

/// Paleta e estilos centrais, extraídos visualmente dos protótipos
/// (HOME, DESCRIÇÃO e FAVORITOS).
class AppColors {
  AppColors._();

  static const Color primaryBlue = Color(0xFF1B4B8F);
  static const Color primaryBlueDark = Color(0xFF12335F);
  static const Color background = Color(0xFFF0F1F3);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color accentYellow = Color(0xFFD6C221);
  static const Color deleteRed = Color(0xFFD32F2F);
  static const Color divider = Color(0xFFE4E4E7);
  static const Color inputFill = Color(0xFFF3F3F5);
}

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      dividerColor: AppColors.divider,
    );
  }
}
