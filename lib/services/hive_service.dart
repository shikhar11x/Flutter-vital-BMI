import 'package:hive_flutter/hive_flutter.dart';
import '../core/constants/app_constants.dart';

/// Hive local storage service
class HiveService {
  static Future<void> initialize() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();

      // Open boxes
      await Hive.openBox<String>(AppConstants.hiveBoxAppPreferences);
      // Note: For ProfileModel and WeightEntryModel, you'd need to register adapters
      // For now, we're using String storage

      print('✅ Hive initialized successfully');
    } catch (e) {
      print('❌ Hive initialization failed: $e');
      rethrow;
    }
  }

  /// Clear all data
  static Future<void> clearAll() async {
    try {
      await Hive.deleteBoxFromDisk(AppConstants.hiveBoxAppPreferences);
    } catch (e) {
      print('❌ Failed to clear Hive: $e');
    }
  }
}