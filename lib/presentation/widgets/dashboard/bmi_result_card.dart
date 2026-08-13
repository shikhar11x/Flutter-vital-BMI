import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_radius.dart';
import '../common/app_card.dart';

/// BMI Result Card showing BMI value and category
class BMIResultCard extends StatelessWidget {
  final double bmi;
  final String category;
  final String healthyRangeMin;
  final String healthyRangeMax;

  const BMIResultCard({
    Key? key,
    required this.bmi,
    required this.category,
    required this.healthyRangeMin,
    required this.healthyRangeMax,
  }) : super(key: key);

  Color _getCategoryColor() {
    switch (category) {
      case 'Underweight':
        return AppColors.underweight;
      case 'Normal Weight':
        return AppColors.normal;
      case 'Overweight':
        return AppColors.overweight;
      case 'Obese':
        return AppColors.obese;
      default:
        return AppColors.primary;
    }
  }

  IconData _getCategoryIcon() {
    switch (category) {
      case 'Underweight':
        return Icons.trending_down;
      case 'Normal Weight':
        return Icons.check_circle;
      case 'Overweight':
        return Icons.warning;
      case 'Obese':
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor();
    final categoryIcon = _getCategoryIcon();

    return AppCard(
      backgroundColor: AppColors.cardBg,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          // BMI Value
          Text(
            'Your BMI',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            bmi.toStringAsFixed(1),
            style: AppTextStyles.bmiDisplay,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Category with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                categoryIcon,
                color: categoryColor,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                category,
                style: AppTextStyles.bmiCategory.copyWith(
                  color: categoryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Divider
          Container(
            height: 1,
            color: AppColors.surfaceBg,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Healthy Range
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Healthy Range',
                    style: AppTextStyles.statLabel,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '$healthyRangeMin - $healthyRangeMax',
                    style: AppTextStyles.statValue,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}