import '../entities/weight_entry_entity.dart';

/// Abstract weight repository interface
/// Defines contracts for weight entry operations
abstract class WeightRepository {
  /// Add a weight entry
  Future<WeightEntryEntity> addWeightEntry({
    required String profileId,
    required double weight,
    required String unit,
    required DateTime date,
  });

  /// Get weight entry by ID
  Future<WeightEntryEntity?> getWeightEntry({required String entryId});

  /// Get all weight entries for a profile
  Future<List<WeightEntryEntity>> getWeightEntries({
    required String profileId,
  });

  /// Get weight entries for last N days
  Future<List<WeightEntryEntity>> getWeightEntriesForDays({
    required String profileId,
    required int days,
  });

  /// Get latest weight entry
  Future<WeightEntryEntity?> getLatestWeightEntry({
    required String profileId,
  });

  /// Update weight entry
  Future<WeightEntryEntity> updateWeightEntry({
    required WeightEntryEntity entry,
  });

  /// Delete weight entry
  Future<void> deleteWeightEntry({required String entryId});

  /// Check if weight entry exists for date
  Future<bool> hasEntryForDate({
    required String profileId,
    required DateTime date,
  });

  /// Stream of weight entries for profile
  Stream<List<WeightEntryEntity>> getWeightEntriesStream({
    required String profileId,
  });

  /// Stream of last N days weight entries
  Stream<List<WeightEntryEntity>> getWeightEntriesStreamForDays({
    required String profileId,
    required int days,
  });
}