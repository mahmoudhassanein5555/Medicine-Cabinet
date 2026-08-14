import 'package:medicine_cabinet/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });
  Future<UserEntity> signInWithGoogle();
  Future<void> forgotPassword({required String email});
  Future<void> logOut();
}
