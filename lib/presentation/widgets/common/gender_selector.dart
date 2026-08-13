import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_radius.dart';

/// Gender selector widget
class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final Function(String) onGenderChanged;
  final String? label;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    const genders = ['Male', 'Female', 'Other'];
    const icons = [Icons.male, Icons.female, Icons.help_outline];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: AppTextStyles.label,
          ),
        if (label != null) const SizedBox(height: AppSpacing.sm),
        Row(
          children: List.generate(
            genders.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () => onGenderChanged(genders[index]),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < genders.length - 1 ? AppSpacing.md : 0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.lg,
                  ),
                  decoration: BoxDecoration(
                    color: selectedGender == genders[index]
                        ? AppColors.primary
                        : AppColors.surfaceBg,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: selectedGender == genders[index]
                          ? AppColors.primary
                          : AppColors.textHint,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        color: selectedGender == genders[index]
                            ? Colors.white
                            : AppColors.textHint,
                        size: 24,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        genders[index],
                        style: AppTextStyles.label.copyWith(
                          color: selectedGender == genders[index]
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}