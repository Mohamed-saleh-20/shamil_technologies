import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.vibrantTeal, // Main accent color
    scaffoldBackgroundColor: AppColors.deepSpaceNavy, // Main background
    fontFamily: 'Cairo', // A good font for Arabic
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: AppColors.white),
      titleLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w600, color: AppColors.white),
      bodyMedium: TextStyle(fontSize: 16.0, color: AppColors.grey),
      labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: AppColors.deepSpaceNavy)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.vibrantTeal, // Button color
        foregroundColor: AppColors.deepSpaceNavy, // Text color on button
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16, 
          fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}