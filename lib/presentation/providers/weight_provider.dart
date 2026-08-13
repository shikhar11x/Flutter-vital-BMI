import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/weight_entry_entity.dart';
import '../../data/datasources/weight_datasource.dart';
import '../../data/repositories/weight_repository_impl.dart';
import '../../domain/repositories/weight_repository.dart';
import '../../core/errors/app_exception.dart';

// ============== DATASOURCES ==============

final weightDatasourceProvider = Provider<WeightDatasource>((ref) {
  return FirestoreWeightDatasource();
});

// ============== REPOSITORIES ==============

final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  final datasource = ref.watch(weightDatasourceProvider);
  return WeightRepositoryImpl(datasource: datasource);
});

// ============== STATE CLASS ==============

class WeightState {
  final List<WeightEntryEntity> entries;
  final bool isLoading;
  final String? error;

  const WeightState({
    this.entries = const [],
    this.isLoading = false,
    this.error,
  });

  WeightState copyWith({
    List<WeightEntryEntity>? entries,
    bool? isLoading,
    String? error,
  }) {
    return WeightState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// ============== STATE NOTIFIER ==============

class WeightNotifier extends StateNotifier<WeightState> {
  final WeightRepository repository;
  final String profileId;

  WeightNotifier(this.repository, this.profileId) : super(const WeightState());

  Future<void> addWeightEntry({
    required double weight,
    required String unit,
    required DateTime date,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final entry = await repository.addWeightEntry(
        profileId: profileId,
        weight: weight,
        unit: unit,
        date: date,
      );

      state = state.copyWith(
        entries: [...state.entries, entry],
        isLoading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> loadWeightEntries() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final entries = await repository.getWeightEntries(
        profileId: profileId,
      );

      state = state.copyWith(entries: entries, isLoading: false);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> loadWeightEntriesForDays(int days) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final entries = await repository.getWeightEntriesForDays(
        profileId: profileId,
        days: days,
      );

      state = state.copyWith(entries: entries, isLoading: false);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> updateWeightEntry(WeightEntryEntity entry) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await repository.updateWeightEntry(entry: entry);

      final updatedEntries = state.entries
          .map((e) => e.id == updated.id ? updated : e)
          .toList();

      state = state.copyWith(entries: updatedEntries, isLoading: false);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> deleteWeightEntry(String entryId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await repository.deleteWeightEntry(entryId: entryId);

      final updatedEntries =
          state.entries.where((e) => e.id != entryId).toList();

      state = state.copyWith(entries: updatedEntries, isLoading: false);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }
}

// ============== FAMILY PROVIDER ==============

final weightProvider =
    StateNotifierProvider.family<WeightNotifier, WeightState, String>(
  (ref, profileId) {
    final repository = ref.watch(weightRepositoryProvider);
    return WeightNotifier(repository, profileId);
  },
);

// ============== DERIVED PROVIDERS ==============

final weightEntriesProvider = Provider.family<List<WeightEntryEntity>, String>(
  (ref, profileId) {
    return ref.watch(weightProvider(profileId)).entries;
  },
);

final last7DaysWeightProvider = Provider.family<List<WeightEntryEntity>, String>(
  (ref, profileId) {
    final entries = ref.watch(weightEntriesProvider(profileId));
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return entries
        .where((e) => e.date.isAfter(sevenDaysAgo))
        .toList();
  },
);

final weightLoadingProvider = Provider.family<bool, String>(
  (ref, profileId) {
    return ref.watch(weightProvider(profileId)).isLoading;
  },
);

final weightErrorProvider = Provider.family<String?, String>(
  (ref, profileId) {
    return ref.watch(weightProvider(profileId)).error;
  },
);