import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/weight_entry_model.dart';
import '../../core/errors/error_handler.dart';

/// Weight entry datasource interface
abstract class WeightDatasource {
  /// Add a weight entry
  Future<WeightEntryModel> addWeightEntry({
    required String profileId,
    required double weight,
    required String unit,
    required DateTime date,
  });

  /// Get weight entry by ID
  Future<WeightEntryModel?> getWeightEntry({required String entryId});

  /// Get all weight entries for a profile
  Future<List<WeightEntryModel>> getWeightEntries({required String profileId});

  /// Get weight entries for last N days
  Future<List<WeightEntryModel>> getWeightEntriesForDays({
    required String profileId,
    required int days,
  });

  /// Get latest weight entry
  Future<WeightEntryModel?> getLatestWeightEntry({required String profileId});

  /// Update weight entry
  Future<WeightEntryModel> updateWeightEntry({required WeightEntryModel entry});

  /// Delete weight entry
  Future<void> deleteWeightEntry({required String entryId});

  /// Check if weight entry exists for date
  Future<bool> hasEntryForDate({
    required String profileId,
    required DateTime date,
  });

  /// Stream of weight entries
  Stream<List<WeightEntryModel>> getWeightEntriesStream({
    required String profileId,
  });

  /// Stream of last N days weight entries
  Stream<List<WeightEntryModel>> getWeightEntriesStreamForDays({
    required String profileId,
    required int days,
  });
}

/// Firestore weight entry datasource implementation
class FirestoreWeightDatasource implements WeightDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get reference to weight entries subcollection
  /// Path: users/{userId}/profiles/{profileId}/weightEntries
  CollectionReference _getWeightEntriesCollection(
    String userId,
    String profileId,
  ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('profiles')
        .doc(profileId)
        .collection('weightEntries');
  }

  @override
  Future<WeightEntryModel> addWeightEntry({
    required String profileId,
    required double weight,
    required String unit,
    required DateTime date,
  }) async {
    try {
      const uuid = Uuid();
      final entryId = uuid.v4();
      final now = DateTime.now();

      // Note: In real implementation, get userId from auth
      final userId = _firestore.app.name; // Placeholder - should be from auth

      final entry = WeightEntryModel(
        id: entryId,
        profileId: profileId,
        weight: weight,
        unit: unit,
        date: date,
        recordedAt: now,
      );

      await _getWeightEntriesCollection(
        userId,
        profileId,
      ).doc(entryId).set(entry.toJson());

      return entry;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<WeightEntryModel?> getWeightEntry({required String entryId}) async {
    try {
      // Note: This requires knowing userId and profileId
      // In real implementation, you'd need to search across all
      return null;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<List<WeightEntryModel>> getWeightEntries({
    required String profileId,
  }) async {
    try {
      // Note: Requires userId from auth context
      // This is a limitation - in real app, pass userId as parameter
      return [];
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<List<WeightEntryModel>> getWeightEntriesForDays({
    required String profileId,
    required int days,
  }) async {
    try {
      // Note: Requires userId from auth context
      return [];
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<WeightEntryModel?> getLatestWeightEntry({
    required String profileId,
  }) async {
    try {
      // Note: Requires userId from auth context
      return null;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<WeightEntryModel> updateWeightEntry({
    required WeightEntryModel entry,
  }) async {
    try {
      // Note: Requires userId and profileId from context
      final updated = entry.copyWith();
      return updated;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<void> deleteWeightEntry({required String entryId}) async {
    try {
      // Note: Requires userId and profileId from context
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<bool> hasEntryForDate({
    required String profileId,
    required DateTime date,
  }) async {
    try {
      // Note: Requires userId from context
      return false;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Stream<List<WeightEntryModel>> getWeightEntriesStream({
    required String profileId,
  }) {
    // Note: Requires userId from auth context
    return Stream.value([]);
  }

  @override
  Stream<List<WeightEntryModel>> getWeightEntriesStreamForDays({
    required String profileId,
    required int days,
  }) {
    // Note: Requires userId from auth context
    return Stream.value([]);
  }
}
