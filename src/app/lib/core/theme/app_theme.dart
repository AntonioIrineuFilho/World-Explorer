import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBlue = Color(0xFF254D8D);
  static const Color buttonBlue = Color(0xFF123771);
  static const Color background = Color(0xFFF1F2F4);
  static const Color textGray = Color(0xFF505050);
  static const Color favoriteYellow = Color(0xFFE5CE06);
  static const Color cardWhite = Color(0xFFFFFFFF);

  static const Color deleteRed = Color(0xFFBD272D);
}

class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Inter';

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      dividerColor: AppColors.textGray,
    );
  }
}
