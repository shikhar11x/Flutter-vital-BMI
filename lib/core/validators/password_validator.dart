import '../constants/app_constants.dart';

/// Password validation logic
class PasswordValidator {
  PasswordValidator._(); // Private constructor

  /// Validate password
  /// Returns error message if invalid, null if valid
  static String? validate(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    // Check minimum length
    if (password.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }

    // Check maximum length
    if (password.length > AppConstants.maxPasswordLength) {
      return 'Password must not exceed ${AppConstants.maxPasswordLength} characters';
    }

    return null; // Valid
  }

  /// Validate password confirmation
  /// Returns error message if passwords don't match
  static String? validateConfirmation({
    required String password,
    required String confirmPassword,
  }) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null; // Valid
  }

  /// Check password strength
  /// Returns strength level: weak, medium, strong
  static String getStrength(String password) {
    if (password.length < 8) {
      return 'weak';
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasNumbers = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar =
        password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]'));

    int strengthScore = 0;
    if (hasUppercase) strengthScore++;
    if (hasLowercase) strengthScore++;
    if (hasNumbers) strengthScore++;
    if (hasSpecialChar) strengthScore++;

    if (strengthScore <= 1) return 'weak';
    if (strengthScore <= 2) return 'medium';
    return 'strong';
  }

  /// Check if password is valid (returns boolean)
  static bool isValid(String? password) {
    return validate(password) == null;
  }
}