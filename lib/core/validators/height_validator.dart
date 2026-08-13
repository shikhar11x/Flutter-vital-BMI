import '../constants/app_constants.dart';

/// Height validation logic
/// Handles validation for both CM and Inches formats
class HeightValidator {
  HeightValidator._(); // Private constructor

  /// Validate height in centimeters
  /// Returns error message if invalid, null if valid
  static String? validateCm(String? height) {
    if (height == null || height.isEmpty) {
      return 'Height is required';
    }

    final value = double.tryParse(height);
    if (value == null) {
      return 'Height must be a valid number';
    }

    if (value < AppConstants.minHeightCm) {
      return 'Height must be at least ${AppConstants.minHeightCm.toInt()} cm';
    }

    if (value > AppConstants.maxHeightCm) {
      return 'Height cannot exceed ${AppConstants.maxHeightCm.toInt()} cm';
    }

    return null; // Valid
  }

  /// Validate height in inches
  /// Returns error message if invalid, null if valid
  static String? validateInches(String? height) {
    if (height == null || height.isEmpty) {
      return 'Height is required';
    }

    final value = double.tryParse(height);
    if (value == null) {
      return 'Height must be a valid number';
    }

    if (value < AppConstants.minHeightInches) {
      return 'Height must be at least ${AppConstants.minHeightInches.toInt()} inches';
    }

    if (value > AppConstants.maxHeightInches) {
      return 'Height cannot exceed ${AppConstants.maxHeightInches.toInt()} inches';
    }

    return null; // Valid
  }

  /// Validate feet
  static String? validateFeet(String? feet) {
    if (feet == null || feet.isEmpty) {
      return 'Feet is required';
    }

    final value = int.tryParse(feet);
    if (value == null) {
      return 'Feet must be a whole number';
    }

    if (value < 2 || value > 9) {
      return 'Height must be between 2 and 9 feet';
    }

    return null; // Valid
  }

  /// Validate inches
  static String? validateInchesField(String? inches) {
    if (inches == null || inches.isEmpty) {
      return 'Inches is required';
    }

    final value = int.tryParse(inches);
    if (value == null) {
      return 'Inches must be a whole number';
    }

    if (value < 0 || value > 11) {
      return 'Inches must be between 0 and 11';
    }

    return null; // Valid
  }

  /// Validate combined feet and inches
  static String? validateFeetInches({
    required String feet,
    required String inches,
  }) {
    String? feetError = validateFeet(feet);
    if (feetError != null) return feetError;

    String? inchesError = validateInchesField(inches);
    if (inchesError != null) return inchesError;

    return null; // Valid
  }

  /// Check if height is valid (returns boolean)
  static bool isValidCm(String? height) {
    return validateCm(height) == null;
  }

  static bool isValidInches(String? height) {
    return validateInches(height) == null;
  }

  /// Generic validate method that defaults to centimeters
  /// Can be used with TextFormField validator
  static String? validate(String? value) {
    return validateCm(value);
  }
}
