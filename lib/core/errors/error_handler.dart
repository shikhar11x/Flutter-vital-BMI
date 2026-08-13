import 'dart:developer' as developer;
import 'app_exception.dart';

/// Centralized error handling and mapping
/// Converts various exceptions to user-friendly messages
class ErrorHandler {
  ErrorHandler._(); // Private constructor

  /// Handle Firebase Auth errors
  static AppException handleAuthError(dynamic error) {
    final errorCode = error.code ?? '';
    final errorMessage = error.message ?? '';

    switch (errorCode) {
      case 'user-not-found':
        return UserNotFoundAuthException();
      case 'wrong-password':
        return WrongPasswordAuthException();
      case 'user-disabled':
        return UserDisabledAuthException();
      case 'too-many-requests':
        return TooManyRequestsAuthException();
      case 'email-already-in-use':
        return EmailAlreadyInUseAuthException();
      case 'weak-password':
        return WeakPasswordAuthException();
      case 'invalid-email':
        return InvalidEmailAuthException();
      case 'network-request-failed':
        return NetworkAuthException();
      default:
        return AuthException(
          message: errorMessage.isNotEmpty
              ? errorMessage
              : 'Authentication failed. Please try again.',
          code: errorCode,
          originalException: error,
        );
    }
  }

  /// Handle Firestore errors
  static AppException handleFirestoreError(dynamic error) {
    final errorCode = error.code ?? '';
    final errorMessage = error.message ?? '';

    switch (errorCode) {
      case 'not-found':
        return DocumentNotFoundFirestoreException();
      case 'permission-denied':
        return PermissionDeniedFirestoreException();
      case 'unauthenticated':
        return AuthException(
          message: 'Please login to continue',
          code: 'unauthenticated',
        );
      case 'unavailable':
        return NetworkException(
          message: 'Service temporarily unavailable. Please try again.',
        );
      default:
        return FirestoreException(
          message: errorMessage.isNotEmpty
              ? errorMessage
              : 'Database error. Please try again.',
          code: errorCode,
          originalException: error,
        );
    }
  }

  /// Handle generic exceptions
  static AppException handleException(dynamic error) {
    // Firebase Auth errors
    if (error.runtimeType.toString().contains('FirebaseAuthException')) {
      return handleAuthError(error);
    }

    // Firestore errors
    if (error.runtimeType.toString().contains('FirebaseException')) {
      return handleFirestoreError(error);
    }

    // Timeout errors
    if (error is TimeoutException) {
      return error;
    }

    // Network errors
    if (error is NetworkException) {
      return error;
    }

    // Already an AppException
    if (error is AppException) {
      return error;
    }

    // Unknown error
    return UnknownException(
      message: error.toString().isNotEmpty
          ? error.toString()
          : 'An unexpected error occurred.',
    );
  }

  /// Get user-friendly error message
  static String getUserMessage(AppException exception) {
    return exception.message;
  }

  /// Check if error is network-related
  static bool isNetworkError(AppException exception) {
    return exception.code == 'network-error' ||
        exception.code == 'timeout-error' ||
        exception is NetworkException;
  }

  /// Check if error is auth-related
  static bool isAuthError(AppException exception) {
    return exception is AuthException;
  }

  /// Check if error is validation-related
  static bool isValidationError(AppException exception) {
    return exception is ValidationException;
  }

  /// Log error for debugging (using dart:developer instead of print)
  static void logError(AppException exception) {
    developer.log(
      exception.message,
      name: 'VitalBMI.ERROR',
      error: exception.code,
    );
  }

  /// Log error with stack trace (using dart:developer)
  static void logErrorWithStack(
    AppException exception,
    StackTrace stackTrace,
  ) {
    developer.log(
      exception.message,
      name: 'VitalBMI.ERROR',
      error: exception.code,
      stackTrace: stackTrace,
    );
  }
}