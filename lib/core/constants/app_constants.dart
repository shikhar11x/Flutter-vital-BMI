/// Global app constants and configuration
class AppConstants {
  AppConstants._(); // Private constructor

  // APP INFORMATION
  static const String appName = 'VitalBMI';
  static const String appSubtitle = 'Smart BMI & Weight Tracker';
  static const String appVersion = '1.0.0';

  // VALIDATION CONSTANTS
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int maxNameLength = 50;
  static const int minNameLength = 2;

  // WEIGHT CONSTRAINTS (reasonable boundaries)
  static const double minWeight = 20.0; // 20 kg
  static const double maxWeight = 300.0; // 300 kg

  // HEIGHT CONSTRAINTS (reasonable boundaries)
  static const double minHeightCm = 50.0; // 50 cm
  static const double maxHeightCm = 250.0; // 250 cm
  static const double minHeightInches = 20.0; // 20 inches
  static const double maxHeightInches = 100.0; // 100 inches

  // WEIGHT HISTORY
  static const int weightHistoryDays = 7; // Show last 7 days
  static const int maxWeightEntriesPerDay = 3; // Max entries per day

  // PROFILE LIMITS
  static const int maxProfiles = 10; // Max profiles per user
  static const int minProfiles = 1; // Min profiles per user

  // TIMEOUTS
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration debounceDelay = Duration(milliseconds: 500);

  // CACHE DURATION
  static const Duration cacheDuration = Duration(hours: 1);

  // URL AND ENDPOINTS
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  static const String termsOfServiceUrl = 'https://example.com/terms';
  static const String supportEmail = 'support@vitalbmi.com';

  // DATE FORMATS
  static const String dateFormatShort = 'dd MMM';
  static const String dateFormatFull = 'dd MMM, yyyy';
  static const String dateFormatChartX = 'dd/MM';

  // HIVE BOX NAMES
  static const String hiveBoxAppPreferences = 'app_preferences';
  static const String hiveBoxLocalProfiles = 'local_profiles';
  static const String hiveBoxWeightEntries = 'local_weight_entries';

  // HIVE KEY NAMES
  static const String keyActiveProfileId = 'active_profile_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyWeightUnit = 'weight_unit';
  static const String keyHeightUnit = 'height_unit';
  static const String keyNotificationsEnabled = 'notifications_enabled';

  // DEFAULT VALUES
  static const String defaultWeightUnit = 'kg';
  static const String defaultHeightUnit = 'cm';
  static const String defaultThemeMode = 'dark';
}