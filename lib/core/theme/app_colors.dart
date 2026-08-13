import 'package:flutter/material.dart';

/// Centralized color palette for VitalBMI app
/// Matches the premium dark theme design
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // BACKGROUND COLORS
  static const Color darkBg = Color(0xFF0F1419); // Main dark background
  static const Color cardBg = Color(0xFF1A1F2E); // Card background
  static const Color surfaceBg = Color(0xFF252C3E); // Surface color

  // PRIMARY COLORS
  static const Color primary = Color(0xFF8B5CF6); // Vibrant purple
  static const Color primaryLight = Color(0xFFA78BFA); // Light purple
  static const Color primaryDark = Color(0xFF7C3AED); // Dark purple

  // SECONDARY COLORS
  static const Color secondary = Color(0xFFEC4899); // Pink/Magenta

  // BMI CATEGORY COLORS
  static const Color underweight = Color(0xFF3B82F6); // Blue
  static const Color normal = Color(0xFF10B981); // Green
  static const Color overweight = Color(0xFFF59E0B); // Amber/Orange
  static const Color obese = Color(0xFFEF4444); // Red

  // NEUTRAL COLORS
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // TEXT COLORS
  static const Color textPrimary = Color(0xFFFFFFFF); // White text on dark bg
  static const Color textSecondary = Color(0xFFB3B3B3); // Light grey text
  static const Color textHint = Color(0xFF6B7280); // Muted grey text

  // STATUS COLORS
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // GRADIENT COLORS (for charts and special elements)
  static const List<Color> chartGradient = [
    Color(0xFF8B5CF6), // Purple
    Color(0xFF3B82F6), // Blue
  ];

  static const List<Color> loginGradient = [
    Color(0xFF7C3AED), // Dark purple
    Color(0xFF8B5CF6), // Light purple
  ];

  // TRANSPARENCY HELPERS
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  // SHADOW COLOR
  static const Color shadowColor = Color(0x26000000); // For depth
}