import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Custom text field widget
class AppTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;
  final int minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;

  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isObscured = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: _isObscured,
          validator: widget.validator,
          onChanged: widget.onChanged,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          enabled: widget.enabled,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textHint,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}

/// Email input field
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EmailTextField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Email',
      hintText: 'enter@example.com',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }
}

/// Password input field
class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Password',
      hintText: 'Minimum 6 characters',
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: validator,
      prefixIcon: const Icon(Icons.lock_outlined),
    );
  }
}

/// Number input field
class NumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const NumberTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
