import '../constants/bmi_constants.dart';

/// BMI Calculation utility
/// Handles all BMI-related calculations and categorizations
class BMICalculator {
  BMICalculator._(); // Private constructor

  /// Calculate BMI from weight and height
  /// 
  /// [weight] - Weight in the specified unit
  /// [weightUnit] - 'kg' or 'lbs'
  /// [height] - Height in the specified unit
  /// [heightUnit] - 'cm' or 'in'
  /// 
  /// Returns BMI value rounded to 1 decimal place
  static double calculateBMI({
    required double weight,
    required String weightUnit,
    required double height,
    required String heightUnit,
  }) {
    // Convert weight to kg
    double weightKg = weightUnit.toLowerCase() == 'lbs'
        ? weight * BMIConstants.poundsToKg
        : weight;

    // Convert height to meters
    double heightM;
    if (heightUnit.toLowerCase() == 'cm') {
      heightM = height / 100;
    } else if (heightUnit.toLowerCase() == 'in') {
      heightM = height * BMIConstants.inchToMeter;
    } else if (heightUnit.toLowerCase() == 'ft') {
      heightM = height * BMIConstants.footToMeter;
    } else {
      throw ArgumentError('Invalid height unit: $heightUnit');
    }

    // BMI Formula: weight(kg) / (height(m)^2)
    double bmi = weightKg / (heightM * heightM);

    // Round to 1 decimal place
    return double.parse(bmi.toStringAsFixed(1));
  }

  /// Get BMI category based on BMI value
  /// 
  /// Returns one of:
  /// - 'Underweight' (BMI < 18.5)
  /// - 'Normal Weight' (18.5 - 24.9)
  /// - 'Overweight' (25.0 - 29.9)
  /// - 'Obese' (30.0+)
  static String getBMICategory(double bmi) {
    if (bmi < BMIConstants.underweightMax) {
      return BMIConstants.categoryUnderweight;
    } else if (bmi < BMIConstants.overweightMin) {
      return BMIConstants.categoryNormal;
    } else if (bmi < BMIConstants.obeseMin) {
      return BMIConstants.categoryOverweight;
    } else {
      return BMIConstants.categoryObese;
    }
  }

  /// Get BMI description
  static String getBMIDescription(String category) {
    return BMIConstants.categoryDescriptions[category] ??
        'Unknown BMI category';
  }

  /// Get BMI category color as hex string
  /// Used for UI styling
  static String getBMICategoryColor(String category) {
    switch (category) {
      case BMIConstants.categoryUnderweight:
        return '#3B82F6'; // Blue
      case BMIConstants.categoryNormal:
        return '#10B981'; // Green
      case BMIConstants.categoryOverweight:
        return '#F59E0B'; // Orange
      case BMIConstants.categoryObese:
        return '#EF4444'; // Red
      default:
        return '#6B7280'; // Grey
    }
  }

  /// Get BMI position for visualization scale (0.0 to 1.0)
  /// Used for BMI gauge/scale indicator
  /// 
  /// Scale:
  /// 0.0 = Underweight (BMI 10)
  /// 0.25 = Normal start (BMI 18.5)
  /// 0.5 = Normal end (BMI 24.9)
  /// 0.75 = Overweight end (BMI 29.9)
  /// 1.0 = Obese (BMI 40+)
  static double getBMIScalePosition(double bmi) {
    if (bmi < 10) return 0.0;
    if (bmi >= 40) return 1.0;

    // Map BMI to 0.0 - 1.0 scale
    // Reasonable range: 10 - 40 BMI
    return (bmi - 10) / 30;
  }

  /// Calculate weight change between two weights
  /// Returns positive if weight increased, negative if decreased
  static double calculateWeightChange(
    double currentWeight,
    double previousWeight,
  ) {
    return currentWeight - previousWeight;
  }

  /// Format BMI value for display
  static String formatBMI(double bmi) {
    return bmi.toStringAsFixed(1);
  }

  /// Get healthy weight range for a given height
  /// Returns map with min, max weight in kg
  static Map<String, double> getHealthyWeightRange(double heightCm) {
    double heightM = heightCm / 100;
    return {
      'min': double.parse(
        (18.5 * heightM * heightM).toStringAsFixed(1),
      ),
      'max': double.parse(
        (24.9 * heightM * heightM).toStringAsFixed(1),
      ),
    };
  }

  /// Check if BMI is in healthy range
  static bool isHealthyBMI(double bmi) {
    return bmi >= BMIConstants.normalMin &&
        bmi <= BMIConstants.normalMax;
  }
}