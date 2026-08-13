import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ============== SETTINGS MODEL ==============

class AppSettings {
  final String theme;
  final String weightUnit;
  final String heightUnit;
  final bool notificationsEnabled;

  const AppSettings({
    this.theme = 'dark',
    this.weightUnit = 'KG',
    this.heightUnit = 'CM',
    this.notificationsEnabled = true,
  });

  AppSettings copyWith({
    String? theme,
    String? weightUnit,
    String? heightUnit,
    bool? notificationsEnabled,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      weightUnit: weightUnit ?? this.weightUnit,
      heightUnit: heightUnit ?? this.heightUnit,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

// ============== STATE NOTIFIER ==============

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings());

  void setTheme(String theme) {
    state = state.copyWith(theme: theme);
  }

  void setWeightUnit(String unit) {
    state = state.copyWith(weightUnit: unit);
  }

  void setHeightUnit(String unit) {
    state = state.copyWith(heightUnit: unit);
  }

  void setNotifications(bool enabled) {
    state = state.copyWith(notificationsEnabled: enabled);
  }
}

// ============== MAIN PROVIDER ==============

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

// ============== DERIVED PROVIDERS ==============

final themeProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).theme;
});

final weightUnitProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).weightUnit;
});

final heightUnitProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).heightUnit;
});

final notificationsProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).notificationsEnabled;
});