import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logOut();
  }
}
