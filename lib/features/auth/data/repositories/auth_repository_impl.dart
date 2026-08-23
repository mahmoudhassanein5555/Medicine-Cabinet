import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.login(email: email, password: password);

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final user = await remoteDataSource.signInWithGoogle();

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<void> logOut() {
    return remoteDataSource.logout();
  }
}
