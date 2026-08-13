import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/validators/email_validator.dart';
import '../../../core/validators/password_validator.dart';
import '../../../core/validators/name_validator.dart';
import '../../../core/errors/app_exception.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/app_scaffold.dart';
import '../../providers/auth_provider.dart';

/// Register/Sign up screen
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to terms and conditions'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    try {
      await ref
          .read(authProvider.notifier)
          .registerWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            name: _nameController.text.trim(),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
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
      title: 'Create Account 🎉',
      showBackButton: true,
      backgroundColor: AppColors.darkBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Join VitalBMI today', style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.xl),

              // Full Name field
              AppTextField(
                label: 'Full Name',
                hintText: 'Enter your name',
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: NameValidator.validate,
                prefixIcon: const Icon(Icons.person_outlined),
              ),
              const SizedBox(height: AppSpacing.lg),

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
              const SizedBox(height: AppSpacing.lg),

              // Confirm Password field
              AppTextField(
                label: 'Confirm Password',
                hintText: 'Re-enter your password',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  return PasswordValidator.validateConfirmation(
                    password: _passwordController.text,
                    confirmPassword: value ?? '',
                  );
                },
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Terms & Privacy checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to ',
                        style: AppTextStyles.bodySmall,
                        children: [
                          TextSpan(
                            text: 'Terms',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' & ', style: AppTextStyles.bodySmall),
                          TextSpan(
                            text: 'Privacy',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Create Account button
              AppButton(
                label: 'CREATE ACCOUNT',
                onPressed: _handleRegister,
                isLoading: isLoading,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account? ',
                    style: AppTextStyles.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
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
