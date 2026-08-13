import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We'll implement this in Phase 4 after creating screens
// This is just the structure placeholder

/// GoRouter configuration for VitalBMI
/// Handles all navigation in the app

final goRouterProvider = Provider<GoRouter>((ref) {
  // TODO: Implement after screens are created
  // This will include:
  // - Splash screen routing
  // - Auth screens (login, register, forgot password)
  // - Profile setup
  // - Main dashboard with bottom nav
  // - All other screens
  
  return GoRouter(
    routes: [
      // Routes will be defined here in Phase 4
    ],
  );
});

// Route names for easy reference
class RouteNames {
  RouteNames._();
  
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String profileSetup = '/profile-setup';
  static const String dashboard = '/dashboard';
  static const String history = '/history';
  static const String profiles = '/profiles';
  static const String settings = '/settings';
}