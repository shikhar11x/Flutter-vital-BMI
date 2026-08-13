import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../../core/errors/app_exception.dart';
import '../../core/errors/error_handler.dart';

/// Firebase authentication datasource
abstract class AuthDatasource {
  Future<UserModel?> getCurrentUser();

  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithGoogle();

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> logout();

  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
    String? photoUrl,
  });

  Stream<UserModel?> authStateChanges();
}

/// Firebase auth datasource implementation - Compatible with latest versions
class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // FIXED for google_sign_in 7.2.0
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _googleSignInInitialized = false;

  Future<void> _initializeGoogleSignIn() async {
    if (_googleSignInInitialized) return;

    await _googleSignIn.initialize();
    _googleSignInInitialized = true;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName,
        photoUrl: user.photoURL,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw UnknownException(message: 'Failed to create user account');
      }

      await user.updateDisplayName(name);

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: name,
        photoUrl: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.handleAuthError(e);
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw UnknownException(message: 'Failed to login');
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName,
        photoUrl: user.photoURL,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.handleAuthError(e);
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      // Step 1: Initialize Google Sign-In
      await _initializeGoogleSignIn();

      // Step 2: Sign in with Google
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      // Step 3: Get Google authentication credentials
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // Step 4: Create Firebase credential from Google ID token
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Step 5: Sign in to Firebase using the credential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        throw UnknownException(
          message: 'Failed to sign in with Google',
        );
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName,
        photoUrl: user.photoURL,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.handleAuthError(e);
    } on GoogleSignInException catch (e) {
      throw GoogleSignInAuthException(
        message: 'Google sign-in error: ${e.toString()}',
      );
    } on GoogleSignInAuthException {
      rethrow;
    } catch (e) {
      throw GoogleSignInAuthException(
        message: 'Google sign-in error: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.handleAuthError(e);
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
    String? photoUrl,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw UnknownException(message: 'No user logged in');
      }

      if (name != null) {
        await user.updateDisplayName(name);
      }

      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }

      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;

      if (updatedUser == null) {
        throw UnknownException(
          message: 'Failed to update profile',
        );
      }

      return UserModel(
        id: updatedUser.uid,
        email: updatedUser.email ?? '',
        name: updatedUser.displayName,
        photoUrl: updatedUser.photoURL,
        createdAt:
            updatedUser.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.handleAuthError(e);
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName,
        photoUrl: user.photoURL,
        createdAt:
            user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });
  }
}