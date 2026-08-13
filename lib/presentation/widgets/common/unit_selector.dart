import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_radius.dart';

/// Unit selector widget (e.g., KG/LBS, CM/IN)
class UnitSelector extends StatelessWidget {
  final String selectedUnit;
  final List<String> units;
  final Function(String) onUnitChanged;
  final String? label;

  const UnitSelector({
    super.key,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
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
            units.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () => onUnitChanged(units[index]),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < units.length - 1 ? AppSpacing.sm : 0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: selectedUnit == units[index]
                        ? AppColors.primary
                        : AppColors.surfaceBg,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: selectedUnit == units[index]
                          ? AppColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    units[index],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.label.copyWith(
                      color: selectedUnit == units[index]
                          ? Colors.white
                          : AppColors.textSecondary,
                      fontWeight: selectedUnit == units[index]
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
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

/// Weight unit selector (KG/LBS)
class WeightUnitSelector extends StatelessWidget {
  final String selectedUnit;
  final Function(String) onUnitChanged;

  const WeightUnitSelector({
    super.key,
    required this.selectedUnit,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return UnitSelector(
      selectedUnit: selectedUnit,
      units: const ['KG', 'LBS'],
      onUnitChanged: onUnitChanged,
    );
  }
}

/// Height unit selector (CM/IN)
class HeightUnitSelector extends StatelessWidget {
  final String selectedUnit;
  final Function(String) onUnitChanged;

  const HeightUnitSelector({
    super.key,
    required this.selectedUnit,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return UnitSelector(
      selectedUnit: selectedUnit,
      units: const ['CM', 'IN'],
      onUnitChanged: onUnitChanged,
    );
  }
}