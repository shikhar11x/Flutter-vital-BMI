/// Centralized spacing/padding constants
/// Ensures consistent margins and padding throughout the app
class AppSpacing {
  AppSpacing._(); // Private constructor

  // MINI SPACING (4px increments)
  static const double xs = 4.0; // Extra small
  static const double sm = 8.0; // Small
  static const double md = 12.0; // Medium-small
  static const double lg = 16.0; // Medium
  static const double xl = 24.0; // Large
  static const double xxl = 32.0; // Extra large
  static const double xxxl = 48.0; // Extra extra large

  // PADDING PRESETS
  /// Horizontal padding for main screens
  static const double screenPaddingH = 16.0;

  /// Vertical padding for main screens
  static const double screenPaddingV = 16.0;

  /// Card internal padding
  static const double cardPadding = 16.0;

  /// Button padding (vertical)
  static const double buttonPaddingV = 16.0;

  /// Button padding (horizontal)
  static const double buttonPaddingH = 24.0;

  // SPACING BETWEEN ELEMENTS
  /// Gap between form fields
  static const double formFieldGap = 16.0;

  /// Gap between section headers and content
  static const double sectionGap = 24.0;

  /// Gap between cards in a list
  static const double cardGap = 12.0;

  /// Gap between bottom nav and content
  static const double bottomNavGap = 16.0;

  /// App bar height
  static const double appBarHeight = 56.0;

  /// Bottom navigation height
  static const double bottomNavHeight = 64.0;
}