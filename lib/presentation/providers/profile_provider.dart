import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/datasources/profile_datasource.dart';
import 'auth_provider.dart';

// ============= PROFILE REPOSITORY PROVIDER =============

/// Provider for Profile Datasource
final profileDatasourceProvider = Provider<ProfileDatasource>((ref) {
  return FirestoreProfileDatasource();
});

/// Provider for Profile Repository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final datasource = ref.watch(profileDatasourceProvider);
  return ProfileRepositoryImpl(datasource: datasource);
});

// ============= PROFILE STATE PROVIDERS =============

/// Get all profiles for current user
final userProfilesProvider = FutureProvider<List<ProfileEntity>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final profileRepository = ref.watch(profileRepositoryProvider);

  return authState.whenData((user) async {
    if (user == null) return [];
    return profileRepository.getUserProfiles(userId: user.id);
  }).then((value) => value.asData?.value ?? []);
});

/// Stream of user's profiles
final userProfilesStreamProvider =
    StreamProvider<List<ProfileEntity>>((ref) async* {
  final authState = ref.watch(authStateProvider);

  await for (final user in authState.stream) {
    if (user == null) {
      yield [];
    } else {
      final profileRepository = ref.watch(profileRepositoryProvider);
      yield* profileRepository.getUserProfilesStream(userId: user.id);
    }
  }
});

/// Get active profile
final activeProfileProvider = FutureProvider<ProfileEntity?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final profileRepository = ref.watch(profileRepositoryProvider);

  return authState.whenData((user) async {
    if (user == null) return null;
    return profileRepository.getActiveProfile(userId: user.id);
  }).then((value) => value.asData?.value);
});

/// Stream of active profile
final activeProfileStreamProvider =
    StreamProvider<ProfileEntity?>((ref) async* {
  final authState = ref.watch(authStateProvider);

  await for (final user in authState.stream) {
    if (user == null) {
      yield null;
    } else {
      final profileRepository = ref.watch(profileRepositoryProvider);
      yield* profileRepository.getActiveProfileStream(userId: user.id);
    }
  }
});

// ============= PROFILE ACTIONS (StateNotifier) =============

/// Profile state notifier for manual state management
class ProfileStateNotifier extends StateNotifier<ProfileEntity?> {
  final ProfileRepository _profileRepository;
  final String _userId;

  ProfileStateNotifier(this._profileRepository, this._userId) : super(null);

  /// Create new profile
  Future<ProfileEntity> createProfile({
    required String name,
    required String gender,
    required double height,
    required String heightUnit,
    required double weight,
    required String weightUnit,
  }) async {
    try {
      final profile = await _profileRepository.createProfile(
        userId: _userId,
        name: name,
        gender: gender,
        height: height,
        heightUnit: heightUnit,
        weight: weight,
        weightUnit: weightUnit,
      );
      state = profile;
      return profile;
    } catch (e) {
      rethrow;
    }
  }

  /// Update profile
  Future<ProfileEntity> updateProfile({
    required ProfileEntity profile,
  }) async {
    try {
      final updated = await _profileRepository.updateProfile(profile: profile);
      state = updated;
      return updated;
    } catch (e) {
      rethrow;
    }
  }

  /// Set active profile
  Future<void> setActiveProfile({required String profileId}) async {
    try {
      await _profileRepository.setActiveProfile(
        userId: _userId,
        profileId: profileId,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Delete profile
  Future<void> deleteProfile({required String profileId}) async {
    try {
      await _profileRepository.deleteProfile(profileId: profileId);
      state = null;
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for Profile State Notifier
final profileStateNotifierProvider =
    StateNotifierProvider.family<ProfileStateNotifier, ProfileEntity?, String>(
        (ref, userId) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileStateNotifier(profileRepository, userId);
});