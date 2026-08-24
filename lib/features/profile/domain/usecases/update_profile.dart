import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

class UpdateProfile {
  final ProfileRepository repository;

  const UpdateProfile(this.repository);

  Future<ProfileEntity> call({
    required String name,
    String? photoUrl,
  }) {
    return repository.updateProfile(
      name: name,
      photoUrl: photoUrl,
    );
  }
}