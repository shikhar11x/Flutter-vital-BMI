import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized typography system for VitalBMI
/// Ensures consistent text styling across the app
class AppTextStyles {
  AppTextStyles._();

  // ============= HEADINGS =============

  /// Extra Large Heading - 32px, Bold
  /// Used for: Onboarding title, main screens
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Large Heading - 28px, Bold
  /// Used for: Screen titles
  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.3,
  );

  /// Medium Heading - 24px, Semi-Bold
  /// Used for: Card titles, section headers
  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// Small Heading - 20px, Semi-Bold
  /// Used for: Subsection headers
  static const TextStyle heading4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ============= BODY TEXT =============

  /// Body Large - 16px, Regular
  /// Used for: Main paragraph text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Body Medium - 14px, Regular
  /// Used for: Secondary text, descriptions
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  /// Body Small - 12px, Regular
  /// Used for: Helper text, labels
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.5,
  );

  // ============= LABELS & BUTTONS =============

  /// Button Large - 16px, Semi-Bold
  /// Used for: Primary buttons
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  /// Button Medium - 14px, Semi-Bold
  /// Used for: Secondary buttons
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.3,
  );

  /// Label - 12px, Semi-Bold
  /// Used for: Field labels, badges
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  // ============= SPECIAL STYLES =============

  /// BMI Display - 48px, Bold
  /// Used for: Large BMI number display
  static const TextStyle bmiDisplay = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.0,
    letterSpacing: -1,
  );

  /// BMI Category - 18px, Semi-Bold
  /// Used for: BMI category label
  static const TextStyle bmiCategory = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    height: 1.3,
  );

  /// Stat Value - 24px, Bold
  /// Used for: Weight/Height values on dashboard
  static const TextStyle statValue = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  /// Stat Label - 12px, Regular
  /// Used for: Weight/Height labels
  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
    letterSpacing: 0.3,
  );

  /// Caption - 11px, Regular
  /// Used for: Smallest text, timestamps
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.4,
  );

  // ============= UTILITY METHODS =============

  /// Get colored heading
  static TextStyle getHeading1({Color? color}) =>
      heading1.copyWith(color: color ?? AppColors.textPrimary);

  static TextStyle getHeading2({Color? color}) =>
      heading2.copyWith(color: color ?? AppColors.textPrimary);

  /// Get colored body text
  static TextStyle getBodyLarge({Color? color}) =>
      bodyLarge.copyWith(color: color ?? AppColors.textPrimary);

  static TextStyle getBodyMedium({Color? color}) =>
      bodyMedium.copyWith(color: color ?? AppColors.textSecondary);
}