import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../../core/errors/app_exception.dart';

/// Concrete implementation of AuthRepository
/// Bridges datasource and domain layer
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl({required AuthDatasource datasource})
      : _datasource = datasource;

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final user = await _datasource.getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await _datasource.getCurrentUser();
      return user?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _datasource.registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      return user.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _datasource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    try {
      final user = await _datasource.loginWithGoogle();
      return user.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _datasource.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      // TODO: Implement password reset with OOB code
      throw UnknownException(
        message: 'Password reset not yet implemented',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateUserProfile({
    required String userId,
    String? name,
    String? photoUrl,
  }) async {
    try {
      final user = await _datasource.updateUserProfile(
        userId: userId,
        name: name,
        photoUrl: photoUrl,
      );
      return user.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _datasource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount({required String userId}) async {
    try {
      // TODO: Implement account deletion
      throw UnknownException(
        message: 'Account deletion not yet implemented',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return _datasource.authStateChanges().map((model) => model?.toEntity());
  }
}