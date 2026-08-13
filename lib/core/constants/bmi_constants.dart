/// BMI calculation constants and categories
class BMIConstants {
  BMIConstants._(); // Private constructor

  // BMI CATEGORY RANGES
  static const double underweightMax = 18.5;
  static const double normalMin = 18.5;
  static const double normalMax = 24.9;
  static const double overweightMin = 25.0;
  static const double overweightMax = 29.9;
  static const double obeseMin = 30.0;

  // BMI FORMULA: weight(kg) / (height(m)^2)

  // CONVERSION FACTORS
  static const double poundsToKg = 0.453592;
  static const double inchToMeter = 0.0254;
  static const double footToMeter = 0.3048;
  static const double inchesPerFoot = 12.0;

  // BMI CATEGORY NAMES
  static const String categoryUnderweight = 'Underweight';
  static const String categoryNormal = 'Normal Weight';
  static const String categoryOverweight = 'Overweight';
  static const String categoryObese = 'Obese';

  // BMI CATEGORY DESCRIPTIONS
  static const Map<String, String> categoryDescriptions = {
    categoryUnderweight:
        'Your BMI indicates you are underweight. Consider consulting with a healthcare provider.',
    categoryNormal:
        'Great job! Your BMI is in the normal range. Keep maintaining a healthy lifestyle.',
    categoryOverweight:
        'Your BMI suggests you are overweight. Consider increasing physical activity and balanced diet.',
    categoryObese:
        'Your BMI indicates obesity. We recommend consulting with a healthcare provider.',
  };

  // HEALTHY BMI RANGES BY CATEGORY
  static const Map<String, String> healthyRanges = {
    categoryUnderweight: 'Below 18.5',
    categoryNormal: '18.5 - 24.9 (Ideal)',
    categoryOverweight: '25.0 - 29.9',
    categoryObese: '30.0 or higher',
  };

  // HEALTHY WEIGHT RANGES (for display)
  // These are simplified recommendations
  static Map<String, dynamic> getHealthyWeightRange(
    double heightInCm, {
    required String gender,
  }) {
    // BMI range: 18.5 - 24.9
    double heightInM = heightInCm / 100;
    double minWeight = 18.5 * (heightInM * heightInM);
    double maxWeight = 24.9 * (heightInM * heightInM);

    return {
      'min': minWeight.toStringAsFixed(1),
      'max': maxWeight.toStringAsFixed(1),
      'unit': 'kg'
    };
  }
}