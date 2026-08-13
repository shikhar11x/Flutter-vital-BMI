import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/bmi_calculator.dart';
import 'profile_provider.dart';

/// BMI result model
class BMIResult {
  final double bmi;
  final String category;
  final String description;
  final Map<String, double> healthyRange;

  const BMIResult({
    required this.bmi,
    required this.category,
    required this.description,
    required this.healthyRange,
  });
}

/// Calculate BMI for active profile
final bmiProvider = FutureProvider<BMIResult?>((ref) async {
  final activeProfile = ref.watch(activeProfileProvider);

  return activeProfile.whenData((profile) {
    if (profile == null) return null;

    final bmi = BMICalculator.calculateBMI(
      weight: profile.weight,
      weightUnit: profile.weightUnit,
      height: profile.height,
      heightUnit: profile.heightUnit,
    );

    final category = BMICalculator.getBMICategory(bmi);
    final description = BMICalculator.getBMIDescription(category);
    final healthyRange =
        BMICalculator.getHealthyWeightRange(profile.height);

    return BMIResult(
      bmi: bmi,
      category: category,
      description: description,
      healthyRange: healthyRange,
    );
  }).then((value) => value.asData?.value);
});

/// BMI scale position (0.0 to 1.0)
final bmiScalePositionProvider = FutureProvider<double>((ref) async {
  final bmiResult = ref.watch(bmiProvider);

  return bmiResult.whenData((result) {
    if (result == null) return 0.0;
    return BMICalculator.getBMIScalePosition(result.bmi);
  }).then((value) => value.asData?.value ?? 0.0);
});