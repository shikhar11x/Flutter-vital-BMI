import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/profile_model.dart';
import '../../core/errors/app_exception.dart';
import '../../core/errors/error_handler.dart';

/// Firestore profile datasource
/// Handles profile operations in Firestore
abstract class ProfileDatasource {
  /// Create a new profile
  Future<ProfileModel> createProfile({
    required String userId,
    required String name,
    required String gender,
    required double height,
    required String heightUnit,
    required double weight,
    required String weightUnit,
  });

  /// Get profile by ID
  Future<ProfileModel?> getProfile({required String profileId});

  /// Get all profiles for a user
  Future<List<ProfileModel>> getUserProfiles({required String userId});

  /// Get active profile
  Future<ProfileModel?> getActiveProfile({required String userId});

  /// Update profile
  Future<ProfileModel> updateProfile({required ProfileModel profile});

  /// Set active profile
  Future<void> setActiveProfile({
    required String userId,
    required String profileId,
  });

  /// Delete profile
  Future<void> deleteProfile({required String profileId});

  /// Stream of user profiles
  Stream<List<ProfileModel>> getUserProfilesStream({required String userId});

  /// Stream of active profile
  Stream<ProfileModel?> getActiveProfileStream({required String userId});
}

/// Firestore profile datasource implementation
class FirestoreProfileDatasource implements ProfileDatasource {
  final FirebaseFirestore _firestore;

  FirestoreProfileDatasource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Firestore path: users/{userId}/profiles/{profileId}
  CollectionReference _getUserProfilesCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('profiles');
  }

  @override
  Future<ProfileModel> createProfile({
    required String userId,
    required String name,
    required String gender,
    required double height,
    required String heightUnit,
    required double weight,
    required String weightUnit,
  }) async {
    try {
      const uuid = Uuid();
      final profileId = uuid.v4();
      final now = DateTime.now();

      final profile = ProfileModel(
        id: profileId,
        ownerId: userId,
        name: name,
        gender: gender,
        height: height,
        heightUnit: heightUnit,
        weight: weight,
        weightUnit: weightUnit,
        bmi: null, // Will be calculated by backend
        bmiCategory: null,
        isActive: true, // First profile is active
        createdAt: now,
        updatedAt: now,
      );

      await _getUserProfilesCollection(userId).doc(profileId).set(
            profile.toJson(),
          );

      return profile;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<ProfileModel?> getProfile({required String profileId}) async {
    try {
      // Need to query across all users - not efficient, use real implementation
      // For now, return null - this should be refactored
      return null;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<List<ProfileModel>> getUserProfiles({required String userId}) async {
    try {
      final snapshot = await _getUserProfilesCollection(userId).get();

      return snapshot.docs
          .map((doc) => ProfileModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<ProfileModel?> getActiveProfile({required String userId}) async {
    try {
      final snapshot = await _getUserProfilesCollection(userId)
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return ProfileModel.fromJson(
        snapshot.docs.first.data() as Map<String, dynamic>,
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<ProfileModel> updateProfile({required ProfileModel profile}) async {
    try {
      final updated = profile.copyWith(updatedAt: DateTime.now());

      await _getUserProfilesCollection(profile.ownerId)
          .doc(profile.id)
          .update(updated.toJson());

      return updated;
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<void> setActiveProfile({
    required String userId,
    required String profileId,
  }) async {
    try {
      final collection = _getUserProfilesCollection(userId);

      // Set all to inactive
      final allProfiles = await collection.get();
      for (var doc in allProfiles.docs) {
        await doc.reference.update({'isActive': false});
      }

      // Set selected to active
      await collection.doc(profileId).update({'isActive': true});
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<void> deleteProfile({required String profileId}) async {
    try {
      // Need userId to delete - refactor this
      // For now, this is a placeholder
      throw UnknownException(
        message: 'Profile deletion not fully implemented',
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Stream<List<ProfileModel>> getUserProfilesStream({required String userId}) {
    return _getUserProfilesCollection(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProfileModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<ProfileModel?> getActiveProfileStream({required String userId}) {
    return _getUserProfilesCollection(userId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;

      return ProfileModel.fromJson(
        snapshot.docs.first.data() as Map<String, dynamic>,
      );
    });
  }
}