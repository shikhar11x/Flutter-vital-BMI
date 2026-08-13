import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/user_entity.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/errors/app_exception.dart';

// ============== DATASOURCES ==============

final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  return FirebaseAuthDatasource();
});

// ============== REPOSITORIES ==============

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final datasource = ref.watch(authDatasourceProvider);
  return AuthRepositoryImpl(datasource: datasource);
});

// ============== STATE CLASS ==============

class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// ============== STATE NOTIFIER ==============

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(const AuthState());

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await repository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthState(user: user);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await repository.loginWithGoogle();
      state = AuthState(user: user);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await repository.registerWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      state = AuthState(user: user);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await repository.sendPasswordResetEmail(email: email);
      state = state.copyWith(isLoading: false);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await repository.logout();
      state = const AuthState();
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      rethrow;
    }
  }

  Future<void> checkAuthState() async {
    try {
      final user = repository.getCurrentUser();
      state = AuthState(user: await user);
    } catch (e) {
      state = const AuthState();
    }
  }
}

// ============== MAIN PROVIDER ==============

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// ============== DERIVED PROVIDERS ==============

final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user;
});

final isLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

final isAuthLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.error;
});