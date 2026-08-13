import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/profile_entity.dart';
import '../../data/datasources/profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../core/errors/app_exception.dart';

// ============== DATASOURCES ==============

final profileDatasourceProvider = Provider<ProfileDatasource>((ref) {
  return FirestoreProfileDatasource();
});

// ============== REPOSITORIES ==============

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final datasource = ref.watch(profileDatasourceProvider);
  return ProfileRepositoryImpl(datasource: datasource);
});

// ============== STATE CLASS ==============

class ProfileState {
  final List<ProfileEntity> profiles;
  final ProfileEntity? activeProfile;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.profiles = const [],
    this.activeProfile,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    List<ProfileEntity>? profiles,
    ProfileEntity? activeProfile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      profiles: profiles ?? this.profiles,
      activeProfile: activeProfile ?? this.activeProfile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// ============== STATE NOTIFIER ==============

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository repository;
  final String userId;

  ProfileNotifier(this.repository, this.userId) : super(const ProfileState());

  Future<void> createProfile({
    required String name,
    required String gender,
    required double height,
    required String heightUnit,
    required double weight,
    required String weightUnit,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final profile = await repository.createProfile(
        userId: userId,
        name: name,
        gender: gender,
        height: height,
        heightUnit: heightUnit,
        weight: weight,
        weightUnit: weightUnit,
      );

      state = state.copyWith(
        profiles: [...state.profiles, profile],
        activeProfile: profile,
        isLoading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> loadProfiles() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final profiles = await repository.getUserProfiles(userId: userId);
      final active = await repository.getActiveProfile(userId: userId);

      state = state.copyWith(
        profiles: profiles,
        activeProfile: active,
        isLoading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> setActiveProfile(String profileId) async {
    try {
      await repository.setActiveProfile(userId: userId, profileId: profileId);

      final profile = state.profiles.firstWhere(
        (p) => p.id == profileId,
        orElse: () => state.profiles.first,
      );

      state = state.copyWith(activeProfile: profile);
    } on AppException catch (e) {
      state = state.copyWith(error: e.message);
      rethrow;
    }
  }

  Future<void> updateProfile(ProfileEntity profile) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await repository.updateProfile(profile: profile);

      final updatedProfiles = state.profiles
          .map((p) => p.id == updated.id ? updated : p)
          .toList();

      state = state.copyWith(
        profiles: updatedProfiles,
        activeProfile:
            state.activeProfile?.id == updated.id ? updated : state.activeProfile,
        isLoading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> deleteProfile(String profileId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await repository.deleteProfile(profileId: profileId);

      final updatedProfiles =
          state.profiles.where((p) => p.id != profileId).toList();

      state = state.copyWith(
        profiles: updatedProfiles,
        activeProfile:
            state.activeProfile?.id == profileId ? null : state.activeProfile,
        isLoading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }
}

// ============== FAMILY PROVIDER ==============

final profileProvider =
    StateNotifierProvider.family<ProfileNotifier, ProfileState, String>(
  (ref, userId) {
    final repository = ref.watch(profileRepositoryProvider);
    return ProfileNotifier(repository, userId);
  },
);

// ============== DERIVED PROVIDERS ==============

final userProfilesProvider = Provider.family<List<ProfileEntity>, String>(
  (ref, userId) {
    return ref.watch(profileProvider(userId)).profiles;
  },
);

final activeProfileProvider = Provider.family<ProfileEntity?, String>(
  (ref, userId) {
    return ref.watch(profileProvider(userId)).activeProfile;
  },
);

final profileLoadingProvider = Provider.family<bool, String>(
  (ref, userId) {
    return ref.watch(profileProvider(userId)).isLoading;
  },
);

final profileErrorProvider = Provider.family<String?, String>(
  (ref, userId) {
    return ref.watch(profileProvider(userId)).error;
  },
);