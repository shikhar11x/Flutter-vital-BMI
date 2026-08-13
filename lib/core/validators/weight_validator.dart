import '../constants/app_constants.dart';

/// Weight validation logic
/// Handles validation for both KG and LBS formats
class WeightValidator {
  WeightValidator._(); // Private constructor

  /// Validate weight in kilograms
  /// Returns error message if invalid, null if valid
  static String? validateKg(String? weight) {
    if (weight == null || weight.isEmpty) {
      return 'Weight is required';
    }

    final value = double.tryParse(weight);
    if (value == null) {
      return 'Weight must be a valid number';
    }

    if (value < AppConstants.minWeight) {
      return 'Weight must be at least ${AppConstants.minWeight.toInt()} kg';
    }

    if (value > AppConstants.maxWeight) {
      return 'Weight cannot exceed ${AppConstants.maxWeight.toInt()} kg';
    }

    return null; // Valid
  }

  /// Validate weight in pounds
  /// Returns error message if invalid, null if valid
  static String? validateLbs(String? weight) {
    if (weight == null || weight.isEmpty) {
      return 'Weight is required';
    }

    final value = double.tryParse(weight);
    if (value == null) {
      return 'Weight must be a valid number';
    }

    // Convert to kg for validation (minWeight/maxWeight are in kg)
    const poundsToKg = 0.453592;
    double weightKg = value * poundsToKg;

    if (weightKg < AppConstants.minWeight) {
      int minLbs = (AppConstants.minWeight / poundsToKg).toInt();
      return 'Weight must be at least $minLbs lbs';
    }

    if (weightKg > AppConstants.maxWeight) {
      int maxLbs = (AppConstants.maxWeight / poundsToKg).toInt();
      return 'Weight cannot exceed $maxLbs lbs';
    }

    return null; // Valid
  }

  /// Validate weight by unit
  /// Automatically selects the appropriate validator
  static String? validate({
    required String weight,
    required String unit,
  }) {
    if (unit.toLowerCase() == 'kg') {
      return validateKg(weight);
    } else if (unit.toLowerCase() == 'lbs') {
      return validateLbs(weight);
    } else {
      return 'Invalid weight unit';
    }
  }

  /// Check if weight is valid (returns boolean)
  static bool isValidKg(String? weight) {
    return validateKg(weight) == null;
  }

  static bool isValidLbs(String? weight) {
    return validateLbs(weight) == null;
  }

  static bool isValid({
    required String weight,
    required String unit,
  }) {
    return validate(weight: weight, unit: unit) == null;
  }
}