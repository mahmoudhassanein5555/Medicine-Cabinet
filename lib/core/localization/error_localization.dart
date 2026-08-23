import '../../generated/l10n.dart';

abstract class ErrorLocalization {
  static String getMessage(String key, S l10n) {
    switch (key) {
    // Auth errors
      case 'authInvalidEmail':
        return l10n.authInvalidEmail;

      case 'authUserNotFound':
        return l10n.authUserNotFound;

      case 'authWrongPassword':
        return l10n.authWrongPassword;

      case 'authInvalidCredential':
        return l10n.authInvalidCredential;

      case 'authEmailAlreadyInUse':
        return l10n.authEmailAlreadyInUse;

      case 'authWeakPassword':
        return l10n.authWeakPassword;

      case 'authTooManyRequests':
        return l10n.authTooManyRequests;

      case 'authNetworkError':
        return l10n.authNetworkError;

      case 'authPermissionDenied':
        return l10n.authPermissionDenied;

      case 'authResourceNotFound':
        return l10n.authResourceNotFound;

      case 'authServerError':
        return l10n.authServerError;

      case 'authSessionExpired':
        return l10n.authSessionExpired;

      case 'authUserDisabled':
        return l10n.authUserDisabled;

      case 'authOperationNotAllowed':
        return l10n.authOperationNotAllowed;

      case 'authAccountExistsWithDifferentCredential':
        return l10n.authAccountExistsWithDifferentCredential;

      case 'authGoogleSignInCancelled':
        return l10n.authGoogleSignInCancelled;

      case 'commonTryAgain':
        return l10n.commonTryAgain;

    // Validation errors
      case 'validationEmailRequired':
        return l10n.validationEmailRequired;

      case 'validationInvalidEmail':
        return l10n.validationInvalidEmail;

      case 'validationPasswordRequired':
        return l10n.validationPasswordRequired;

      case 'validationInvalidPassword':
        return l10n.validationInvalidPassword;

      case 'validationPasswordsDoNotMatch':
        return l10n.validationPasswordsDoNotMatch;

      case 'validationNameRequired':
        return l10n.validationNameRequired;

      case 'validationPhoneRequired':
        return l10n.validationPhoneRequired;

      case 'validationInvalidPhone':
        return l10n.validationInvalidPhone;

      case 'validationCodeRequired':
        return l10n.validationCodeRequired;

      case 'validationCodeLength':
        return l10n.validationCodeLength;

      default:
        return l10n.commonTryAgain;
    }
  }
}