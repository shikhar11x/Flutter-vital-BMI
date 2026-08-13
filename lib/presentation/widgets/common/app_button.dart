import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Primary action button
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isEnabled ? Colors.white : AppColors.textHint,
                  ),
                ),
              )
            : Text(
                label,
                style: AppTextStyles.buttonLarge,
              ),
      ),
    );
  }
}

/// Secondary outlined button
class AppOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double? width;
  final double height;

  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          label,
          style: AppTextStyles.buttonLarge,
        ),
      ),
    );
  }
}

/// Text button (no background)
class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: AppTextStyles.buttonMedium.copyWith(
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}

/// Small action button
class AppSmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const AppSmallButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
        child: Text(label, style: AppTextStyles.label),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
        child: Text(label, style: AppTextStyles.label),
      );
    }
  }
}