import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../core/errors/app_exception.dart';

// ============= AUTH REPOSITORY PROVIDER =============

/// Provider for Firebase Auth Datasource
final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  return FirebaseAuthDatasource();
});

/// Provider for Auth Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final datasource = ref.watch(authDatasourceProvider);
  return AuthRepositoryImpl(datasource: datasource);
});

// ============= AUTH STATE PROVIDERS =============

/// Current authenticated user
final currentUserProvider = FutureProvider<UserEntity?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getCurrentUser();
});

/// Stream of auth state changes
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});

/// Check if user is logged in
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.isUserLoggedIn();
});

// ============= AUTH ACTIONS (StateNotifier) =============

/// Auth state notifier for manual state management
class AuthStateNotifier extends StateNotifier<UserEntity?> {
  final AuthRepository _authRepository;

  AuthStateNotifier(this._authRepository) : super(null);

  /// Register with email and password
  Future<UserEntity> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _authRepository.registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      state = user;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Login with email and password
  Future<UserEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = user;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Login with Google
  Future<UserEntity> loginWithGoogle() async {
    try {
      final user = await _authRepository.loginWithGoogle();
      state = user;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  /// Update user profile
  Future<UserEntity> updateUserProfile({
    required String userId,
    String? name,
    String? photoUrl,
  }) async {
    try {
      final user = await _authRepository.updateUserProfile(
        userId: userId,
        name: name,
        photoUrl: photoUrl,
      );
      state = user;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _authRepository.logout();
      state = null;
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for Auth State Notifier
final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, UserEntity?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(authRepository);
});