import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';

/// Settings state
class AppSettings {
  final String themeMode;
  final String weightUnit;
  final String heightUnit;
  final bool notificationsEnabled;

  const AppSettings({
    this.themeMode = 'dark',
    this.weightUnit = 'kg',
    this.heightUnit = 'cm',
    this.notificationsEnabled = true,
  });

  AppSettings copyWith({
    String? themeMode,
    String? weightUnit,
    String? heightUnit,
    bool? notificationsEnabled,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      weightUnit: weightUnit ?? this.weightUnit,
      heightUnit: heightUnit ?? this.heightUnit,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

/// Settings notifier
class SettingsNotifier extends StateNotifier<AppSettings> {
  late Box<String> _preferencesBox;

  SettingsNotifier() : super(const AppSettings()) {
    _initializeBox();
  }

  Future<void> _initializeBox() async {
    try {
      _preferencesBox =
          Hive.box<String>(AppConstants.hiveBoxAppPreferences);
      _loadSettings();
    } catch (e) {
      print('Error initializing settings box: $e');
    }
  }

  void _loadSettings() {
    final themeMode = _preferencesBox.get(
          AppConstants.keyThemeMode,
          defaultValue: 'dark',
        ) ??
        'dark';
    final weightUnit = _preferencesBox.get(
          AppConstants.keyWeightUnit,
          defaultValue: 'kg',
        ) ??
        'kg';
    final heightUnit = _preferencesBox.get(
          AppConstants.keyHeightUnit,
          defaultValue: 'cm',
        ) ??
        'cm';

    state = AppSettings(
      themeMode: themeMode,
      weightUnit: weightUnit,
      heightUnit: heightUnit,
    );
  }

  Future<void> setThemeMode(String mode) async {
    try {
      await _preferencesBox.put(AppConstants.keyThemeMode, mode);
      state = state.copyWith(themeMode: mode);
    } catch (e) {
      print('Error setting theme: $e');
    }
  }

  Future<void> setWeightUnit(String unit) async {
    try {
      await _preferencesBox.put(AppConstants.keyWeightUnit, unit);
      state = state.copyWith(weightUnit: unit);
    } catch (e) {
      print('Error setting weight unit: $e');
    }
  }

  Future<void> setHeightUnit(String unit) async {
    try {
      await _preferencesBox.put(AppConstants.keyHeightUnit, unit);
      state = state.copyWith(heightUnit: unit);
    } catch (e) {
      print('Error setting height unit: $e');
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      state = state.copyWith(notificationsEnabled: enabled);
    } catch (e) {
      print('Error setting notifications: $e');
    }
  }
}

/// Settings provider
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});