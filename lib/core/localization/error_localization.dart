import '../../generated/l10n.dart';

abstract class ErrorLocalization {
  static String getMessage(String key, S l10n) {
    switch (key) {

    // =========================
    // Profile
    // =========================

      case 'profileUserNotAuthenticated':
        return l10n.profileUserNotAuthenticated;

      case 'profileLoadFailed':
        return l10n.profileLoadFailed;

      case 'profileUpdateFailed':
        return l10n.profileUpdateFailed;

      case 'profileNotFound':
        return l10n.profileNotFound;

      case 'profilePermissionDenied':
        return l10n.profilePermissionDenied;

      case 'profileNetworkError':
        return l10n.profileNetworkError;

      case 'profileOperationFailed':
        return l10n.profileOperationFailed;

      case 'profileServerError':
        return l10n.profileServerError;

    // =========================
    // Common
    // =========================

      case 'commonTryAgain':
        return l10n.commonTryAgain;

      default:
        return l10n.commonTryAgain;
    }
  }
}