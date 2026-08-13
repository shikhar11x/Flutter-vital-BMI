import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';
import '../models/profile_model.dart';

/// Concrete implementation of ProfileRepository
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _datasource;

  ProfileRepositoryImpl({required this._datasource});

  @override
  Future<ProfileEntity> createProfile({
    required String userId,
    required String name,
    required String gender,
    required double height,
    required String heightUnit,
    required double weight,
    required String weightUnit,
  }) async {
    try {
      final profile = await _datasource.createProfile(
        userId: userId,
        name: name,
        gender: gender,
        height: height,
        heightUnit: heightUnit,
        weight: weight,
        weightUnit: weightUnit,
      );
      return profile.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileEntity?> getProfile({required String profileId}) async {
    try {
      final profile = await _datasource.getProfile(profileId: profileId);
      return profile?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProfileEntity>> getUserProfiles({required String userId}) async {
    try {
      final profiles = await _datasource.getUserProfiles(userId: userId);
      return profiles.map((p) => p.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileEntity?> getActiveProfile({required String userId}) async {
    try {
      final profile = await _datasource.getActiveProfile(userId: userId);
      return profile?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileEntity> updateProfile({required ProfileEntity profile}) async {
    try {
      final model = await _datasource.updateProfile(
        profile: ProfileModel.fromEntity(profile),
      );
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setActiveProfile({
    required String userId,
    required String profileId,
  }) async {
    try {
      await _datasource.setActiveProfile(userId: userId, profileId: profileId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProfile({required String profileId}) async {
    try {
      await _datasource.deleteProfile(profileId: profileId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> hasProfiles({required String userId}) async {
    try {
      final profiles = await _datasource.getUserProfiles(userId: userId);
      return profiles.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<ProfileEntity>> getUserProfilesStream({required String userId}) {
    return _datasource
        .getUserProfilesStream(userId: userId)
        .map((profiles) => profiles.map((p) => p.toEntity()).toList());
  }

  @override
  Stream<ProfileEntity?> getActiveProfileStream({required String userId}) {
    return _datasource
        .getActiveProfileStream(userId: userId)
        .map((profile) => profile?.toEntity());
  }
}
