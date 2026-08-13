import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/validators/name_validator.dart';
import '../../../core/validators/height_validator.dart';
import '../../../core/validators/weight_validator.dart';
import '../../../core/errors/app_exception.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/gender_selector.dart';
import '../../widgets/common/app_scaffold.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';

/// Profile setup screen (first time setup)
class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  late TextEditingController _nameController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  final _formKey = GlobalKey<FormState>();
  String _selectedGender = 'Male';
  String _selectedHeightUnit = 'CM';
  String _selectedWeightUnit = 'KG';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        throw UnknownException(message: 'User not found');
      }

      await ref
          .read(profileProvider(user.id).notifier)
          .createProfile(
            name: _nameController.text.trim(),
            gender: _selectedGender,
            height: double.parse(_heightController.text),
            heightUnit: _selectedHeightUnit,
            weight: double.parse(_weightController.text),
            weightUnit: _selectedWeightUnit,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile created successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } on AppException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Let\'s Set Up Your Profile ⚙️',
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
                'This helps us calculate your BMI accurately',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Name field
              AppTextField(
                label: 'Your Name',
                hintText: 'e.g., Shikhar',
                controller: _nameController,
                validator: NameValidator.validate,
                prefixIcon: const Icon(Icons.person_outlined),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Gender selector
              GenderSelector(
                selectedGender: _selectedGender,
                onGenderChanged: (gender) {
                  setState(() {
                    _selectedGender = gender;
                  });
                },
                label: 'Gender',
              ),
              const SizedBox(height: AppSpacing.xl),

              // Weight selector
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AppTextField(
                      label: 'Weight',
                      hintText: '70',
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      validator: (value) => WeightValidator.validate(
                        weight: value ?? '',
                        unit: _selectedWeightUnit,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unit',
                          style: AppTextStyles.label,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        DropdownButton<String>(
                          value: _selectedWeightUnit,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedWeightUnit = value ?? 'KG';
                            });
                          },
                          items: const ['KG', 'LBS']
                              .map(
                                (unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Height selector
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AppTextField(
                      label: 'Height',
                      hintText: '175',
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      validator: (value) => _selectedHeightUnit == 'cm'
                          ? HeightValidator.validateCm(value)
                          : HeightValidator.validateInches(value),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unit',
                          style: AppTextStyles.label,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        DropdownButton<String>(
                          value: _selectedHeightUnit,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedHeightUnit = value ?? 'CM';
                            });
                          },
                          items: const ['CM', 'IN']
                              .map(
                                (unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Continue button
              AppButton(
                label: 'CONTINUE →',
                onPressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}