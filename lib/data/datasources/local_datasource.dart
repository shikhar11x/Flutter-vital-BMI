import 'package:hive_flutter/hive_flutter.dart';
import '../models/profile_model.dart';
import '../models/weight_entry_model.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/app_exception.dart';

/// Local Hive datasource
/// Handles local persistence of app data
abstract class LocalDatasource {
  /// Save active profile ID
  Future<void> setActiveProfileId(String profileId);

  /// Get active profile ID
  Future<String?> getActiveProfileId();

  /// Save profile locally
  Future<void> saveProfile(ProfileModel profile);

  /// Get profile from local storage
  Future<ProfileModel?> getProfile(String profileId);

  /// Get all local profiles
  Future<List<ProfileModel>> getAllProfiles();

  /// Delete profile locally
  Future<void> deleteProfile(String profileId);

  /// Save weight entry locally
  Future<void> saveWeightEntry(WeightEntryModel entry);

  /// Get weight entries for profile
  Future<List<WeightEntryModel>> getWeightEntries(String profileId);

  /// Delete weight entry
  Future<void> deleteWeightEntry(String entryId);

  /// Set theme mode
  Future<void> setThemeMode(String mode);

  /// Get theme mode
  Future<String?> getThemeMode();

  /// Set weight unit
  Future<void> setWeightUnit(String unit);

  /// Get weight unit
  Future<String?> getWeightUnit();

  /// Set height unit
  Future<void> setHeightUnit(String unit);

  /// Get height unit
  Future<String?> getHeightUnit();

  /// Clear all local data
  Future<void> clearAll();
}

/// Hive local datasource implementation
class HiveLocalDatasource implements LocalDatasource {
  late Box<ProfileModel> _profileBox;
  late Box<WeightEntryModel> _weightBox;
  late Box<String> _preferencesBox;

  bool _isInitialized = false;

  /// Initialize Hive boxes
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Register adapters if needed
      // Hive.registerAdapter(ProfileModelAdapter());
      // Hive.registerAdapter(WeightEntryModelAdapter());

      // Open boxes
      _profileBox = await Hive.openBox<ProfileModel>(
        AppConstants.hiveBoxLocalProfiles,
      );
      _weightBox = await Hive.openBox<WeightEntryModel>(
        AppConstants.hiveBoxWeightEntries,
      );
      _preferencesBox = await Hive.openBox<String>(
        AppConstants.hiveBoxAppPreferences,
      );

      _isInitialized = true;
    } catch (e) {
      throw StorageException(
        message: 'Failed to initialize local storage: $e',
      );
    }
  }

  @override
  Future<void> setActiveProfileId(String profileId) async {
    try {
      await _preferencesBox.put(
        AppConstants.keyActiveProfileId,
        profileId,
      );
    } catch (e) {
      throw StorageException(
        message: 'Failed to save active profile',
      );
    }
  }

  @override
  Future<String?> getActiveProfileId() async {
    try {
      return _preferencesBox.get(AppConstants.keyActiveProfileId);
    } catch (e) {
      throw StorageException(
        message: 'Failed to get active profile',
      );
    }
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    try {
      await _profileBox.put('profile_${profile.id}', profile);
    } catch (e) {
      throw StorageException(
        message: 'Failed to save profile locally',
      );
    }
  }

  @override
  Future<ProfileModel?> getProfile(String profileId) async {
    try {
      return _profileBox.get('profile_$profileId');
    } catch (e) {
      throw StorageException(
        message: 'Failed to get profile',
      );
    }
  }

  @override
  Future<List<ProfileModel>> getAllProfiles() async {
    try {
      return _profileBox.values.toList();
    } catch (e) {
      throw StorageException(
        message: 'Failed to get profiles',
      );
    }
  }

  @override
  Future<void> deleteProfile(String profileId) async {
    try {
      await _profileBox.delete('profile_$profileId');
    } catch (e) {
      throw StorageException(
        message: 'Failed to delete profile',
      );
    }
  }

  @override
  Future<void> saveWeightEntry(WeightEntryModel entry) async {
    try {
      await _weightBox.put('weight_${entry.id}', entry);
    } catch (e) {
      throw StorageException(
        message: 'Failed to save weight entry',
      );
    }
  }

  @override
  Future<List<WeightEntryModel>> getWeightEntries(String profileId) async {
    try {
      final entries = _weightBox.values.toList();
      return entries.where((e) => e.profileId == profileId).toList();
    } catch (e) {
      throw StorageException(
        message: 'Failed to get weight entries',
      );
    }
  }

  @override
  Future<void> deleteWeightEntry(String entryId) async {
    try {
      await _weightBox.delete('weight_$entryId');
    } catch (e) {
      throw StorageException(
        message: 'Failed to delete weight entry',
      );
    }
  }

  @override
  Future<void> setThemeMode(String mode) async {
    try {
      await _preferencesBox.put(AppConstants.keyThemeMode, mode);
    } catch (e) {
      throw StorageException(message: 'Failed to save theme');
    }
  }

  @override
  Future<String?> getThemeMode() async {
    try {
      return _preferencesBox.get(AppConstants.keyThemeMode);
    } catch (e) {
      throw StorageException(message: 'Failed to get theme');
    }
  }

  @override
  Future<void> setWeightUnit(String unit) async {
    try {
      await _preferencesBox.put(AppConstants.keyWeightUnit, unit);
    } catch (e) {
      throw StorageException(message: 'Failed to save weight unit');
    }
  }

  @override
  Future<String?> getWeightUnit() async {
    try {
      return _preferencesBox.get(AppConstants.keyWeightUnit);
    } catch (e) {
      throw StorageException(message: 'Failed to get weight unit');
    }
  }

  @override
  Future<void> setHeightUnit(String unit) async {
    try {
      await _preferencesBox.put(AppConstants.keyHeightUnit, unit);
    } catch (e) {
      throw StorageException(message: 'Failed to save height unit');
    }
  }

  @override
  Future<String?> getHeightUnit() async {
    try {
      return _preferencesBox.get(AppConstants.keyHeightUnit);
    } catch (e) {
      throw StorageException(message: 'Failed to get height unit');
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _profileBox.clear();
      await _weightBox.clear();
      await _preferencesBox.clear();
    } catch (e) {
      throw StorageException(
        message: 'Failed to clear local data',
      );
    }
  }
}