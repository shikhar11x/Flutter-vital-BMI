import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/validators/email_validator.dart';
import '../../../core/validators/password_validator.dart';
import '../../../core/errors/app_exception.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/app_scaffold.dart';
import '../../providers/auth_provider.dart';

/// Login screen
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref
          .read(authProvider.notifier)
          .loginWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } on AppException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: AppColors.error),
        );
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      await ref.read(authProvider.notifier).loginWithGoogle();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google sign-in successful!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } on AppException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: AppColors.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isAuthLoadingProvider);

    return AppScaffold(
      title: 'Welcome Back! 👋',
      showBackButton: false,
      backgroundColor: AppColors.darkBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login to continue your journey',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Email field
              AppTextField(
                label: 'Email',
                hintText: 'enter@example.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: EmailValidator.validate,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Password field
              AppTextField(
                label: 'Password',
                hintText: 'Minimum 6 characters',
                controller: _passwordController,
                obscureText: true,
                validator: PasswordValidator.validate,
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
              const SizedBox(height: AppSpacing.md),

              // Remember me checkbox
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Text('Remember me', style: AppTextStyles.bodyMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Navigate to forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Login button
              AppButton(
                label: 'LOGIN',
                onPressed: _handleLogin,
                isLoading: isLoading,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.surfaceBg, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Text('OR', style: AppTextStyles.bodySmall),
                  ),
                  Expanded(
                    child: Divider(color: AppColors.surfaceBg, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Google sign-in button
              AppOutlinedButton(
                label: '🔵 Continue with Google',
                onPressed: _handleGoogleSignIn,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to register
                    },
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
