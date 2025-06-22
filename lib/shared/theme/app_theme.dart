import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF5E7C9);
  static const surface = Color(0xFFD4C6B3);
  static const accent = Color(0xFFB2A09D);
  static const primaryText = Color(0xFF645454);
  static const secondaryText = Color(0xFF8C7B8A);
  static const primary = Color(0xFF8C7B8A);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.accent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.surface),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryText),
      bodyMedium: TextStyle(color: AppColors.primaryText),
    ),
  );
}
