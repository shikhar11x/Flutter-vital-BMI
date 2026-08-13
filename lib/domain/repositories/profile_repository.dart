import '../entities/profile_entity.dart';

/// Abstract profile repository interface
/// Defines contracts for profile operations
abstract class ProfileRepository {
  /// Create a new profile
  /// Throws exception on failure
  Future<ProfileEntity> createProfile({
    required String userId,
    required String name,
    required String gender,
    required double height,
    required String heightUnit,
    required double weight,
    required String weightUnit,
  });

  /// Get profile by ID
  Future<ProfileEntity?> getProfile({required String profileId});

  /// Get all profiles for a user
  Future<List<ProfileEntity>> getUserProfiles({required String userId});

  /// Get active profile for user
  Future<ProfileEntity?> getActiveProfile({required String userId});

  /// Update profile
  Future<ProfileEntity> updateProfile({
    required ProfileEntity profile,
  });

  /// Set active profile
  Future<void> setActiveProfile({
    required String userId,
    required String profileId,
  });

  /// Delete profile
  Future<void> deleteProfile({required String profileId});

  /// Check if user has any profiles
  Future<bool> hasProfiles({required String userId});

  /// Stream of user's profiles
  Stream<List<ProfileEntity>> getUserProfilesStream({required String userId});

  /// Stream of active profile
  Stream<ProfileEntity?> getActiveProfileStream({required String userId});
}