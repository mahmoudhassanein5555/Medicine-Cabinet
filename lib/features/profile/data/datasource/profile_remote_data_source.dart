import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({
    required String name,
    String? photoUrl,
  });
}
