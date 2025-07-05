import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primaryGradientStart = Color(0xFF20C997); // Indigo
  static const Color primaryGradientEnd = Color(0xFF17A2B8); // Purple
  static const Color accentGradientStart = Color(0xFF06B6D4); // Cyan
  static const Color accentGradientEnd = Color(0xFF0EA5E9); // Blue
  
  // Background Colors
  static const Color deepSpaceNavy = Color(0xFF0F0F23);
  static const Color darkSlate = Color(0xFF1E1E2E);
  static const Color mediumSlate = Color(0xFF2A2A3E);
  static const Color lightSlate = Color(0xFF363651);
  
  // Text Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFE5E7EB);
  static const Color mediumGray = Color(0xFF9CA3AF);
  static const Color darkGray = Color(0xFF6B7280);
  
  // Accent Colors
  static const Color vibrantTeal = Color(0xFF14B8A6);
  static const Color electricBlue = Color(0xFF3B82F6);
  static const Color neonGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color dangerRed = Color(0xFFEF4444);
  
  // Glassmorphism
  static const Color glassBackground = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGradientStart, primaryGradientEnd],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGradientStart, accentGradientEnd],
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [deepSpaceNavy, darkSlate],
  );
  
  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    colors: [
      Color(0x00FFFFFF),
      Color(0x1AFFFFFF),
      Color(0x00FFFFFF),
    ],
  );
}