import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/bmi_calculator.dart';
import 'profile_provider.dart';

// ============== BMI RESULT MODEL ==============

class BMIResult {
  final double bmi;
  final String category;
  final String healthyRangeMin;
  final String healthyRangeMax;

  const BMIResult({
    required this.bmi,
    required this.category,
    required this.healthyRangeMin,
    required this.healthyRangeMax,
  });
}

// ============== PROVIDER ==============

final bmiProvider = Provider.family<BMIResult?, String>((ref, userId) {
  final activeProfile = ref.watch(activeProfileProvider(userId));

  if (activeProfile == null) {
    return null;
  }

  final bmi = BMICalculator.calculateBMI(
    height: activeProfile.height,
    weight: activeProfile.weight,
    heightUnit: activeProfile.heightUnit,
    weightUnit: activeProfile.weightUnit,
  );

  final category = BMICalculator.getBMICategory(bmi);
  final range = BMICalculator.getHealthyRange(category);

  return BMIResult(
    bmi: bmi,
    category: category,
    healthyRangeMin: range['min'] ?? '18.5',
    healthyRangeMax: range['max'] ?? '24.9',
  );
});

final bmiScalePositionProvider = Provider.family<double, String>(
  (ref, userId) {
    final bmiResult = ref.watch(bmiProvider(userId));

    if (bmiResult == null) {
      return 0.5;
    }

    if (bmiResult.bmi < 18.5) {
      return (bmiResult.bmi / 18.5).clamp(0.0, 0.33);
    } else if (bmiResult.bmi < 25) {
      return 0.33 + ((bmiResult.bmi - 18.5) / 6.5 * 0.33).clamp(0.0, 0.33);
    } else if (bmiResult.bmi < 30) {
      return 0.66 + ((bmiResult.bmi - 25) / 5 * 0.34).clamp(0.0, 0.34);
    } else {
      return 1.0;
    }
  },
);