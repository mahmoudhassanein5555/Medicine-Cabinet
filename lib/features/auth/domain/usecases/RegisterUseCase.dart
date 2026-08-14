import 'package:medicine_cabinet/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String email,
    required String name,
    required String password,
  }) {
    return repository.register(name: name, email: email, password: password);
  }
}
