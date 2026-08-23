import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/auth/domain/entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class GoogleSigninUseCase {
  final AuthRepository repository;

  GoogleSigninUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}
