import '../repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<void> call({
    required String email,
  }) {
    return repository.forgotPassword(
      email: email,
    );
  }
}