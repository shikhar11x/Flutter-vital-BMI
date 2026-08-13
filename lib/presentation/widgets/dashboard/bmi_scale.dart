import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// BMI Scale visualization widget
class BMIScale extends StatelessWidget {
  final double bmiPosition; // 0.0 to 1.0
  final String currentCategory;

  const BMIScale({
    super.key,
    required this.bmiPosition,
    required this.currentCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Scale bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [
                AppColors.underweight,
                AppColors.normal,
                AppColors.overweight,
                AppColors.obese,
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Indicator
        SizedBox(
          height: 40,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                left: bmiPosition * (MediaQuery.of(context).size.width - 32 - 20),
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    Text(
                      currentCategory,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Underweight',
              style: AppTextStyles.caption,
            ),
            Text(
              'Normal',
              style: AppTextStyles.caption,
            ),
            Text(
              'Overweight',
              style: AppTextStyles.caption,
            ),
            Text(
              'Obese',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ],
    );
  }
}