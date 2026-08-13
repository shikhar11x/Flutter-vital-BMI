import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_radius.dart';

/// Stat card showing a single metric
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? change;
  final bool isPositive;
  final String? unit;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.change,
    this.isPositive = false,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.surfaceBg,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            label,
            style: AppTextStyles.statLabel,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTextStyles.statValue,
              ),
              if (unit != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  unit!,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ],
          ),

          // Change indicator
          if (change != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: isPositive ? AppColors.warning : AppColors.normal,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  change!,
                  style: AppTextStyles.caption.copyWith(
                    color: isPositive ? AppColors.warning : AppColors.normal,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Two-column stat cards row
class StatCardsRow extends StatelessWidget {
  final String label1;
  final String value1;
  final String unit1;
  final String? change1;
  final bool isPositive1;
  final String label2;
  final String value2;
  final String unit2;
  final String? change2;
  final bool isPositive2;

  const StatCardsRow({
    super.key,
    required this.label1,
    required this.value1,
    required this.unit1,
    this.change1,
    this.isPositive1 = false,
    required this.label2,
    required this.value2,
    required this.unit2,
    this.change2,
    this.isPositive2 = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            label: label1,
            value: value1,
            unit: unit1,
            change: change1,
            isPositive: isPositive1,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: StatCard(
            label: label2,
            value: value2,
            unit: unit2,
            change: change2,
            isPositive: isPositive2,
          ),
        ),
      ],
    );
  }
}