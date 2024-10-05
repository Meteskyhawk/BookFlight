import 'package:flutter/material.dart';
import '../../constants/app/colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        color: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        toolbarTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.textPrimary,
      appBarTheme: const AppBarTheme(
        color: AppColors.textPrimary,
        iconTheme: IconThemeData(color: AppColors.background),
        toolbarTextStyle: TextStyle(
          color: AppColors.background,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.background,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.background,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          color: AppColors.background,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
