import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  Future<User> signInWithGoogle();

  Future<void> forgotPassword({
    required String email,
  });

  Future<void> logout();
}