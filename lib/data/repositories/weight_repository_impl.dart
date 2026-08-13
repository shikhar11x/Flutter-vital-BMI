import '../../domain/entities/weight_entry_entity.dart';
import '../models/weight_entry_model.dart';
import '../../domain/repositories/weight_repository.dart';
import '../datasources/weight_datasource.dart';

/// Concrete implementation of WeightRepository
class WeightRepositoryImpl implements WeightRepository {
  final WeightDatasource _datasource;

  WeightRepositoryImpl({required WeightDatasource datasource})
      : _datasource = datasource;

  @override
  Future<WeightEntryEntity> addWeightEntry({
    required String profileId,
    required double weight,
    required String unit,
    required DateTime date,
  }) async {
    try {
      final entry = await _datasource.addWeightEntry(
        profileId: profileId,
        weight: weight,
        unit: unit,
        date: date,
      );
      return entry.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeightEntryEntity?> getWeightEntry({required String entryId}) async {
    try {
      final entry = await _datasource.getWeightEntry(entryId: entryId);
      return entry?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WeightEntryEntity>> getWeightEntries({
    required String profileId,
  }) async {
    try {
      final entries = await _datasource.getWeightEntries(profileId: profileId);
      return entries.map((e) => e.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WeightEntryEntity>> getWeightEntriesForDays({
    required String profileId,
    required int days,
  }) async {
    try {
      final entries = await _datasource.getWeightEntriesForDays(
        profileId: profileId,
        days: days,
      );
      return entries.map((e) => e.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeightEntryEntity?> getLatestWeightEntry({
    required String profileId,
  }) async {
    try {
      final entry =
          await _datasource.getLatestWeightEntry(profileId: profileId);
      return entry?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeightEntryEntity> updateWeightEntry({
    required WeightEntryEntity entry,
  }) async {
    try {
      final model = await _datasource.updateWeightEntry(
        entry: WeightEntryModel.fromEntity(entry),
      );
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteWeightEntry({required String entryId}) async {
    try {
      await _datasource.deleteWeightEntry(entryId: entryId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> hasEntryForDate({
    required String profileId,
    required DateTime date,
  }) async {
    try {
      return await _datasource.hasEntryForDate(
        profileId: profileId,
        date: date,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<WeightEntryEntity>> getWeightEntriesStream({
    required String profileId,
  }) {
    return _datasource
        .getWeightEntriesStream(profileId: profileId)
        .map((entries) => entries.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<List<WeightEntryEntity>> getWeightEntriesStreamForDays({
    required String profileId,
    required int days,
  }) {
    return _datasource
        .getWeightEntriesStreamForDays(profileId: profileId, days: days)
        .map((entries) => entries.map((e) => e.toEntity()).toList());
  }
}