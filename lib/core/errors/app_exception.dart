/// Base exception for the app
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppException({required this.message, this.code, this.originalException});

  @override
  String toString() => message;
}

/// Authentication-related exceptions
class AuthException extends AppException {
  AuthException({required super.message, super.code, super.originalException});
}

/// Specific auth exceptions
class UserNotFoundAuthException extends AuthException {
  UserNotFoundAuthException()
    : super(
        message: 'User not found. Please check your email.',
        code: 'user-not-found',
      );
}

class WrongPasswordAuthException extends AuthException {
  WrongPasswordAuthException()
    : super(
        message: 'Incorrect password. Please try again.',
        code: 'wrong-password',
      );
}

class UserDisabledAuthException extends AuthException {
  UserDisabledAuthException()
    : super(
        message: 'This user account has been disabled.',
        code: 'user-disabled',
      );
}

class TooManyRequestsAuthException extends AuthException {
  TooManyRequestsAuthException()
    : super(
        message: 'Too many login attempts. Please try again later.',
        code: 'too-many-requests',
      );
}

class EmailAlreadyInUseAuthException extends AuthException {
  EmailAlreadyInUseAuthException()
    : super(
        message: 'Email already registered. Please login or use another email.',
        code: 'email-already-in-use',
      );
}

class WeakPasswordAuthException extends AuthException {
  WeakPasswordAuthException()
    : super(
        message: 'Password is too weak. Use at least 6 characters.',
        code: 'weak-password',
      );
}

class InvalidEmailAuthException extends AuthException {
  InvalidEmailAuthException()
    : super(message: 'Invalid email address.', code: 'invalid-email');
}

class NetworkAuthException extends AuthException {
  NetworkAuthException()
    : super(
        message: 'Network error. Please check your connection.',
        code: 'network-error',
      );
}

class GoogleSignInAuthException extends AuthException {
  GoogleSignInAuthException({super.message = 'Google sign-in failed'})
    : super(code: 'google-sign-in-error');
}

/// Firestore-related exceptions
class FirestoreException extends AppException {
  FirestoreException({
    required super.message,
    super.code,
    super.originalException,
  });
}

class DocumentNotFoundFirestoreException extends FirestoreException {
  DocumentNotFoundFirestoreException({String? docId})
    : super(
        message: docId != null
            ? 'Document not found: $docId'
            : 'Document not found',
        code: 'document-not-found',
      );
}

class PermissionDeniedFirestoreException extends FirestoreException {
  PermissionDeniedFirestoreException()
    : super(
        message: 'You do not have permission to access this resource.',
        code: 'permission-denied',
      );
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException({required super.message})
    : super(code: 'validation-error');
}

/// Network exceptions
class NetworkException extends AppException {
  NetworkException({
    super.message = 'Network error. Please check your connection.',
  }) : super(code: 'network-error');
}

class TimeoutException extends AppException {
  TimeoutException({super.message = 'Request timed out. Please try again.'})
    : super(code: 'timeout-error');
}

/// Storage/Persistence exceptions
class StorageException extends AppException {
  StorageException({required super.message}) : super(code: 'storage-error');
}

/// Generic/Unknown exceptions
class UnknownException extends AppException {
  UnknownException({
    super.message = 'An unexpected error occurred. Please try again.',
  }) : super(code: 'unknown-error');
}
