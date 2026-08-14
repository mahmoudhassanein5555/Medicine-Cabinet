import 'package:medicine_cabinet/features/auth/domain/entities/user_entity.dart';
import 'package:medicine_cabinet/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  Future<UserEntity>call({required String email,required String password}){
    return repository.login(email: email, password: password);
  }
}