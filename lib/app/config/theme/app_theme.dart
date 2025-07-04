import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    primaryColor: AppColors.primaryGradientStart,
    scaffoldBackgroundColor: AppColors.deepSpaceNavy,
    fontFamily: 'Cairo',
    
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    ),
    
    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.1,
        letterSpacing: -2.0,
      ),
      displayMedium: TextStyle(
        fontSize: 56.0,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.1,
        letterSpacing: -1.5,
      ),
      displaySmall: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.2,
        letterSpacing: -1.0,
      ),
      headlineLarge: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.3,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightGray,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightGray,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: AppColors.lightGray,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.mediumGray,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.darkGray,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightGray,
        letterSpacing: 0.25,
      ),
      labelSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: AppColors.mediumGray,
        letterSpacing: 0.5,
      ),
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.white,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        side: const BorderSide(color: AppColors.glassBorder, width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.glassBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.glassBorder, width: 1),
      ),
    ),
    
    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryGradientStart,
      secondary: AppColors.vibrantTeal,
      background: AppColors.deepSpaceNavy,
      surface: AppColors.darkSlate,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onBackground: AppColors.white,
      onSurface: AppColors.white,
    ),
  );
}