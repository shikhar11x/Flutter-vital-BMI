import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/weight_entry_entity.dart';
import '../../domain/repositories/weight_repository.dart';
import '../../data/repositories/weight_repository_impl.dart';
import '../../data/datasources/weight_datasource.dart';
import 'profile_provider.dart';

// ============= WEIGHT REPOSITORY PROVIDER =============

/// Provider for Weight Datasource
final weightDatasourceProvider = Provider<WeightDatasource>((ref) {
  return FirestoreWeightDatasource();
});

/// Provider for Weight Repository
final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  final datasource = ref.watch(weightDatasourceProvider);
  return WeightRepositoryImpl(datasource: datasource);
});

// ============= WEIGHT STATE PROVIDERS =============

/// Get last 7 days weight entries for active profile
final last7DaysWeightProvider =
    FutureProvider<List<WeightEntryEntity>>((ref) async {
  final activeProfile = ref.watch(activeProfileProvider);
  final weightRepository = ref.watch(weightRepositoryProvider);

  return activeProfile.whenData((profile) async {
    if (profile == null) return [];
    return weightRepository.getWeightEntriesForDays(
      profileId: profile.id,
      days: 7,
    );
  }).then((value) => value.asData?.value ?? []);
});

/// Stream of last 7 days weight entries
final last7DaysWeightStreamProvider =
    StreamProvider<List<WeightEntryEntity>>((ref) async* {
  final activeProfile = ref.watch(activeProfileProvider);

  await for (final profile in activeProfile.stream) {
    if (profile == null) {
      yield [];
    } else {
      final weightRepository = ref.watch(weightRepositoryProvider);
      yield* weightRepository.getWeightEntriesStreamForDays(
        profileId: profile.id,
        days: 7,
      );
    }
  }
});

/// Get all weight entries for active profile
final allWeightEntriesProvider =
    FutureProvider<List<WeightEntryEntity>>((ref) async {
  final activeProfile = ref.watch(activeProfileProvider);
  final weightRepository = ref.watch(weightRepositoryProvider);

  return activeProfile.whenData((profile) async {
    if (profile == null) return [];
    return weightRepository.getWeightEntries(profileId: profile.id);
  }).then((value) => value.asData?.value ?? []);
});

/// Get latest weight entry
final latestWeightEntryProvider =
    FutureProvider<WeightEntryEntity?>((ref) async {
  final activeProfile = ref.watch(activeProfileProvider);
  final weightRepository = ref.watch(weightRepositoryProvider);

  return activeProfile.whenData((profile) async {
    if (profile == null) return null;
    return weightRepository.getLatestWeightEntry(profileId: profile.id);
  }).then((value) => value.asData?.value);
});

// ============= WEIGHT ACTIONS (StateNotifier) =============

/// Weight state notifier
class WeightStateNotifier extends StateNotifier<WeightEntryEntity?> {
  final WeightRepository _weightRepository;

  WeightStateNotifier(this._weightRepository) : super(null);

  /// Add weight entry
  Future<WeightEntryEntity> addWeightEntry({
    required String profileId,
    required double weight,
    required String unit,
    required DateTime date,
  }) async {
    try {
      final entry = await _weightRepository.addWeightEntry(
        profileId: profileId,
        weight: weight,
        unit: unit,
        date: date,
      );
      state = entry;
      return entry;
    } catch (e) {
      rethrow;
    }
  }

  /// Update weight entry
  Future<WeightEntryEntity> updateWeightEntry({
    required WeightEntryEntity entry,
  }) async {
    try {
      final updated = await _weightRepository.updateWeightEntry(entry: entry);
      state = updated;
      return updated;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete weight entry
  Future<void> deleteWeightEntry({required String entryId}) async {
    try {
      await _weightRepository.deleteWeightEntry(entryId: entryId);
      state = null;
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for Weight State Notifier
final weightStateNotifierProvider =
    StateNotifierProvider<WeightStateNotifier, WeightEntryEntity?>((ref) {
  final weightRepository = ref.watch(weightRepositoryProvider);
  return WeightStateNotifier(weightRepository);
});