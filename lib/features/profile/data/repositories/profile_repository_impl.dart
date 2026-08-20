
import 'package:injectable/injectable.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_data_source.dart';
@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  const ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ProfileEntity> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<ProfileEntity> updateProfile({
    required String name,
    String? photoUrl,
  }) async {
    return await remoteDataSource.updateProfile(
      name: name,
      photoUrl: photoUrl,
    );
  }
}