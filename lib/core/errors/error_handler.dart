import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../failure/failure.dart';
import 'error.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is FirebaseAuthException) {
      return _handleFirebaseAuthError(exception);
    } else if (exception is FirebaseException) {
      return _handleFirebaseError(exception);
    } else if (exception is RemoteException) {
      return _handleRemoteError(exception.errormessage);
    } else if (exception is LocalException) {
      return Failure(exception.errormessage);
    } else {
      return Failure('commonTryAgain');
    }
  }

  static Failure _handleFirebaseAuthError(
      FirebaseAuthException exception,
      ) {
    switch (exception.code) {
      case 'invalid-email':
        return Failure('authInvalidEmail');

      case 'user-not-found':
        return Failure('authUserNotFound');

      case 'wrong-password':
        return Failure('authWrongPassword');

      case 'invalid-credential':
        return Failure('authInvalidCredential');

      case 'email-already-in-use':
        return Failure('authEmailAlreadyInUse');

      case 'weak-password':
        return Failure('authWeakPassword');

      case 'too-many-requests':
        return Failure('authTooManyRequests');

      case 'network-request-failed':
        return Failure('authNetworkError');

      default:
        return Failure('commonTryAgain');
    }
  }

  static Failure _handleFirebaseError(
      FirebaseException exception,
      ) {
    switch (exception.code) {
      case 'permission-denied':
        return Failure('authPermissionDenied');

      case 'unavailable':
        return Failure('authNetworkError');

      case 'not-found':
        return Failure('authResourceNotFound');

      case 'deadline-exceeded':
        return Failure('commonTryAgain');

      default:
        return Failure('commonTryAgain');
    }
  }

  static Failure _handleRemoteError(String message) {
    if (message.contains('401') ||
        message.contains('Unauthorized') ||
        message.contains('Unauthenticated')) {
      return Failure('authSessionExpired');
    }

    if (message.contains('403') ||
        message.contains('Forbidden')) {
      return Failure('authPermissionDenied');
    }

    if (message.contains('404') ||
        message.contains('Not Found')) {
      return Failure('authResourceNotFound');
    }

    if (message.contains('500') ||
        message.contains('Internal Server Error')) {
      return Failure('authServerError');
    }

    if (message.contains('422') ||
        message.contains('Unprocessable Content')) {
      return Failure('commonTryAgain');
    }

    if (message.contains('SocketException') ||
        message.contains('Connection failed') ||
        message.contains('HandshakeException')) {
      return Failure('authNetworkError');
    }

    if (message.contains('Timeout') ||
        message.contains('Deadline')) {
      return Failure('commonTryAgain');
    }

    if (message.contains('TypeError') ||
        message.contains('FormatException')) {
      return Failure('commonTryAgain');
    }

    return Failure('commonTryAgain');
  }
}