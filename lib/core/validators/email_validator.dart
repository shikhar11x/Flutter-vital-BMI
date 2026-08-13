/// Email validation logic
class EmailValidator {
  EmailValidator._(); // Private constructor

  /// Validate email format
  /// Returns error message if invalid, null if valid
  static String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    email = email.trim();

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    // Check email length (max 254 characters is RFC standard)
    if (email.length > 254) {
      return 'Email is too long';
    }

    return null; // Valid
  }

  /// Check if email is valid (returns boolean)
  static bool isValid(String? email) {
    return validate(email) == null;
  }

  /// Sanitize email (trim and lowercase)
  static String sanitize(String email) {
    return email.trim().toLowerCase();
  }
}