import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';

/// Splash screen shown on app launch
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start animation and check auth state after 2 seconds
    _animationController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _checkAuthState();
      }
    });
  }

  void _checkAuthState() {
    // Check if user is logged in
    final user = ref.read(currentUserProvider);
    if (user != null) {
      // User is logged in - go to dashboard
      // This will be handled by router in next phase
    } else {
      // User not logged in - go to login
      // This will be handled by router in next phase
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.6),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('VitalBMI', style: AppTextStyles.heading1),
                    const SizedBox(height: 8),
                    Text(
                      'Smart BMI & Weight Tracker',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Loading indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
