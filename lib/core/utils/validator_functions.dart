import '../constants/app_keys.dart';

abstract class Validator {
  static String? validateEmail(String? value) {
    final email = value?.trim();

    if (email == null || email.isEmpty) {
      return 'validationEmailRequired';
    }

    final emailRegex = RegExp(AppKeys.emailRegex);

    if (!emailRegex.hasMatch(email)) {
      return 'validationInvalidEmail';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validationPasswordRequired';
    }

    final passwordRegex = RegExp(AppKeys.passwordRegex);

    if (!passwordRegex.hasMatch(value)) {
      return 'validationInvalidPassword';
    }

    return null;
  }

  static String? validateConfirmPassword(
      String? value,
      String? password,
      ) {
    if (value == null || value.isEmpty) {
      return 'validationPasswordRequired';
    }

    if (value != password) {
      return 'validationPasswordsDoNotMatch';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validationNameRequired';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validationPhoneRequired';
    }

    final phone = value.trim();
    final isValid = RegExp(r'^\+?\d+$').hasMatch(phone);

    if (!isValid || phone.length != 13) {
      return 'validationInvalidPhone';
    }

    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'validationCodeRequired';
    }

    if (value.length < 6) {
      return 'validationCodeLength';
    }

    return null;
  }
}