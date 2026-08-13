import '../constants/app_constants.dart';

/// Name validation logic
class NameValidator {
  NameValidator._(); // Private constructor

  /// Validate name (profile or user name)
  /// Returns error message if invalid, null if valid
  static String? validate(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }

    name = name.trim();

    // Check minimum length
    if (name.length < AppConstants.minNameLength) {
      return 'Name must be at least ${AppConstants.minNameLength} characters';
    }

    // Check maximum length
    if (name.length > AppConstants.maxNameLength) {
      return 'Name must not exceed ${AppConstants.maxNameLength} characters';
    }

    // Check if name contains only valid characters (letters, spaces, hyphens)
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(name)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null; // Valid
  }

  /// Check if name is valid (returns boolean)
  static bool isValid(String? name) {
    return validate(name) == null;
  }

  /// Sanitize name (trim and capitalize)
  static String sanitize(String name) {
    return name.trim();
  }
}