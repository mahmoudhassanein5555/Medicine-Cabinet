import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import '../failure/failure.dart';
import 'error.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is FirebaseException) {
      return _handleFirebaseError(exception);
    } else if (exception is RemoteException) {
      return _handleRemoteError(exception.errormessage);
    } else if (exception is LocalException) {
      return Failure.ofString(exception.errormessage);
    } else if (exception is Exception) {
      return _handleRemoteError(exception.toString());
    } else {
      return Failure((context) => S.of(context).somethingWentWrong);
    }
  }

  static Failure _handleFirebaseError(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return Failure((context) => S.of(context).errorPermissionDenied);
      case 'unavailable':
        return Failure((context) => S.of(context).errorNoInternet);
      case 'not-found':
        return Failure((context) => S.of(context).errorNotFound);
      case 'deadline-exceeded':
        return Failure((context) => S.of(context).errorTimeout);
      default:
        return Failure.ofString(exception.message ?? "Database error occurred.");
    }
  }

  static Failure _handleRemoteError(String message) {
    if (message.contains("401") ||
        message.contains("Unauthorized") ||
        message.contains("Unauthenticated")) {
      return Failure((context) => S.of(context).errorSessionExpired);
    } else if (message.contains("403") || message.contains("Forbidden")) {
      return Failure((context) => S.of(context).errorPermissionDenied);
    } else if (message.contains("404") || message.contains("Not Found")) {
      return Failure((context) => S.of(context).errorNotFound);
    } else if (message.contains("500") || message.contains("Internal Server Error")) {
      return Failure((context) => S.of(context).errorInternalServer);
    } else if (message.contains("422") || message.contains("Unprocessable Content")) {
      return Failure((context) => S.of(context).errorInvalidInput);
    } else if (message.contains("SocketException") ||
        message.contains("Connection failed") ||
        message.contains("HandshakeException")) {
      return Failure((context) => S.of(context).errorNoInternet);
    } else if (message.contains("Timeout") || message.contains("Deadline")) {
      return Failure((context) => S.of(context).errorTimeout);
    } else if (message.contains("TypeError") || message.contains("FormatException")) {
      return Failure((context) => S.of(context).errorTechnicalIssue);
    } else if (message.isNotEmpty && !message.contains("400") && !message.contains("Exception")) {
      return Failure.ofString(message);
    } else {
      return Failure((context) => S.of(context).somethingWentWrong);
    }
  }
}