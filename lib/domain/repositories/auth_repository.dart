import '../entities/user_entity.dart';

/// Abstract authentication repository interface
/// Defines contracts for authentication operations
abstract class AuthRepository {
  /// Check if user is currently logged in
  Future<bool> isUserLoggedIn();

  /// Get current logged-in user
  Future<UserEntity?> getCurrentUser();

  /// Register with email and password
  /// Throws [AuthException] on failure
  Future<UserEntity> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  /// Login with email and password
  /// Throws [AuthException] on failure
  Future<UserEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Login with Google
  /// Throws [AuthException] on failure
  Future<UserEntity> loginWithGoogle();

  /// Send password reset email
  /// Throws [AuthException] on failure
  Future<void> sendPasswordResetEmail({required String email});

  /// Reset password
  /// Throws [AuthException] on failure
  Future<void> resetPassword({
    required String email,
    required String oobCode,
    required String newPassword,
  });

  /// Update user profile (name, photo)
  /// Throws [AuthException] on failure
  Future<UserEntity> updateUserProfile({
    required String userId,
    String? name,
    String? photoUrl,
  });

  /// Logout current user
  /// Throws [AuthException] on failure
  Future<void> logout();

  /// Delete user account
  /// Throws [AuthException] on failure
  Future<void> deleteAccount({required String userId});

  /// Stream of authentication state changes
  Stream<UserEntity?> authStateChanges();
}