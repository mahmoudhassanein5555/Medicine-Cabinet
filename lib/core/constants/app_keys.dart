import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppKeys {
  static const String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const String userId = 'user_id';
  static const String householdId = 'cached_household_id';
  static const String usernameRegex = r'^[a-zA-Z0-9,.-]+$';

  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
}
