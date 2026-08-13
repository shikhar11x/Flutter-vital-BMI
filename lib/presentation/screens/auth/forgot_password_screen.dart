import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/validators/email_validator.dart';
import '../../../core/errors/app_exception.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/app_scaffold.dart';
import '../../providers/auth_provider.dart';

/// Forgot password screen
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendReset() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref
          .read(authProvider.notifier)
          .sendPasswordResetEmail(email: _emailController.text.trim());

      setState(() {
        _emailSent = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset link sent to your email!'),
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
      title: 'Reset Password 🔐',
      showBackButton: true,
      backgroundColor: AppColors.darkBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_emailSent)
                // Success message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 48,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Reset Link Sent!',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Check your email for the password reset link.\nIf you don\'t see it, check your spam folder.',
                            style: AppTextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      label: 'BACK TO LOGIN',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              else
                // Reset form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your email to reset',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Email field
                    AppTextField(
                      label: 'Email Address',
                      hintText: 'enter@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: EmailValidator.validate,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Info message
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'We\'ll send a password reset link to your email. Check your inbox and spam folder.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Send button
                    AppButton(
                      label: 'SEND RESET LINK',
                      onPressed: _handleSendReset,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Back to login link
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Back to Login',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primary,
                          ),
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
