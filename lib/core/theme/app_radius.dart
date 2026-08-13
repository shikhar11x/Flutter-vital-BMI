/// Centralized border radius constants
/// Ensures consistent corner styling throughout the app
class AppRadius {
  AppRadius._(); // Private constructor

  // BORDER RADIUS PRESETS
  /// Extra small radius - 4px
  /// Used for: Small badges, minor elements
  static const double xs = 4.0;

  /// Small radius - 8px
  /// Used for: Input fields, small buttons
  static const double sm = 8.0;

  /// Medium radius - 12px
  /// Used for: Cards, dialogs
  static const double md = 12.0;

  /// Large radius - 16px
  /// Used for: Large cards, main buttons
  static const double lg = 16.0;

  /// Extra large radius - 20px
  /// Used for: Bottom sheets, main containers
  static const double xl = 20.0;

  /// Extra extra large radius - 24px
  /// Used for: Large elevated surfaces
  static const double xxl = 24.0;

  /// Circular - 50 (for profile avatars, etc)
  static const double circular = 50.0;

  // COMMON PRESETS
  /// Standard card border radius
  static const double card = lg;

  /// Standard button border radius
  static const double button = md;

  /// Input field border radius
  static const double input = sm;

  /// Dialog border radius
  static const double dialog = xl;

  /// Bottom sheet border radius (top corners)
  static const double bottomSheet = 20.0;
}