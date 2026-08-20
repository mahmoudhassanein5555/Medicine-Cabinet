import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

class GetProfile {
  final ProfileRepository repository;

  const GetProfile(this.repository);

  Future<ProfileEntity> call() {
    return repository.getProfile();
  }
}