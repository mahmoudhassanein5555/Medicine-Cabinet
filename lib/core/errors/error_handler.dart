import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

import '../failure/failure.dart';
import 'error.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is FirebaseAuthException) {
      return _handleFirebaseAuthError(exception);
    }

    if (exception is FirebaseException) {
      return _handleFirebaseError(exception);
    }

    if (exception is RemoteException) {
      return _handleRemoteError(exception.errormessage);
    }

    if (exception is LocalException) {
      return Failure.ofString(exception.errormessage);
    }

    if (exception is Exception) {
      return _handleRemoteError(exception.toString());
    }

    return Failure(
      (context) => S.of(context).commonError,
    );
  }

  // ---------------------------------------------------------------------------
  // Firebase Authentication
  // ---------------------------------------------------------------------------

  static Failure _handleFirebaseAuthError(
    FirebaseAuthException exception,
  ) {
    switch (exception.code) {
      case 'invalid-email':
        return Failure(
          (context) => S.of(context).authInvalidEmail,
        );

      case 'user-not-found':
        return Failure(
          (context) => S.of(context).authUserNotFound,
        );

      case 'wrong-password':
        return Failure(
          (context) => S.of(context).authWrongPassword,
        );

      case 'invalid-credential':
        return Failure(
          (context) => S.of(context).authInvalidCredential,
        );

      case 'email-already-in-use':
        return Failure(
          (context) => S.of(context).authEmailAlreadyInUse,
        );

      case 'weak-password':
        return Failure(
          (context) => S.of(context).authWeakPassword,
        );

      case 'too-many-requests':
        return Failure(
          (context) => S.of(context).authTooManyRequests,
        );

      case 'network-request-failed':
        return Failure(
          (context) => S.of(context).authNetworkError,
        );

      case 'user-disabled':
        return Failure(
          (context) => S.of(context).authUserDisabled,
        );

      case 'operation-not-allowed':
        return Failure(
          (context) => S.of(context).authOperationNotAllowed,
        );

      case 'account-exists-with-different-credential':
      case 'credential-already-in-use':
        return Failure(
          (context) => S.of(context).authAccountExistsWithDifferentCredential,
        );

      default:
        return Failure(
          (context) => S.of(context).commonTryAgain,
        );
    }
  }

  // ---------------------------------------------------------------------------
  // Firebase / Firestore
  // ---------------------------------------------------------------------------

  static Failure _handleFirebaseError(
    FirebaseException exception,
  ) {
    switch (exception.code) {
      case 'permission-denied':
        return Failure(
          (context) => S.of(context).authPermissionDenied,
        );

      case 'unavailable':
        return Failure(
          (context) => S.of(context).authNetworkError,
        );

      case 'not-found':
        return Failure(
          (context) => S.of(context).authResourceNotFound,
        );

      case 'deadline-exceeded':
        return Failure(
          (context) => S.of(context).commonTryAgain,
        );

      default:
        return Failure(
          (context) => S.of(context).commonTryAgain,
        );
    }
  }

  // ---------------------------------------------------------------------------
  // Remote / API
  // ---------------------------------------------------------------------------

  static Failure _handleRemoteError(String message) {
    final normalizedMessage = message.toLowerCase();

    // 401 - Unauthorized
    if (normalizedMessage.contains('401') ||
        normalizedMessage.contains('unauthorized') ||
        normalizedMessage.contains('unauthenticated')) {
      return Failure(
        (context) => S.of(context).authSessionExpired,
      );
    }

    // 403 - Forbidden
    if (normalizedMessage.contains('403') ||
        normalizedMessage.contains('forbidden')) {
      return Failure(
        (context) => S.of(context).authPermissionDenied,
      );
    }

    // 404 - Not Found
    if (normalizedMessage.contains('404') ||
        normalizedMessage.contains('not found')) {
      return Failure(
        (context) => S.of(context).authResourceNotFound,
      );
    }

    // 422 - Validation error
    if (normalizedMessage.contains('422') ||
        normalizedMessage.contains('unprocessable content') ||
        normalizedMessage.contains('unprocessable entity')) {
      return Failure(
        (context) => S.of(context).commonTryAgain,
      );
    }

    // 500 - Server error
    if (normalizedMessage.contains('500') ||
        normalizedMessage.contains('internal server error')) {
      return Failure(
        (context) => S.of(context).authServerError,
      );
    }

    // Network errors
    if (normalizedMessage.contains('socketexception') ||
        normalizedMessage.contains('connection failed') ||
        normalizedMessage.contains('connection refused') ||
        normalizedMessage.contains('connection reset') ||
        normalizedMessage.contains('handshakeexception') ||
        normalizedMessage.contains('network is unreachable')) {
      return Failure(
        (context) => S.of(context).authNetworkError,
      );
    }

    // Timeout
    if (normalizedMessage.contains('timeout') ||
        normalizedMessage.contains('deadline exceeded') ||
        normalizedMessage.contains('deadline-exceeded')) {
      return Failure(
        (context) => S.of(context).commonTryAgain,
      );
    }

    // Parsing / type errors
    if (normalizedMessage.contains('typeerror') ||
        normalizedMessage.contains('formatexception') ||
        normalizedMessage.contains('jsonexception')) {
      return Failure(
        (context) => S.of(context).commonTryAgain,
      );
    }

    // If we have a meaningful server message, return it.
    if (message.isNotEmpty &&
        !normalizedMessage.contains('exception') &&
        !normalizedMessage.contains('400')) {
      return Failure.ofString(message);
    }

    return Failure(
      (context) => S.of(context).commonError,
    );
  }
}