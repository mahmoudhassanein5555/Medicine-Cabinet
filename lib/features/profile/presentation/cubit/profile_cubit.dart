import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileCubit({
    required this.getProfile,
    required this.updateProfile,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    try {
      final profile = await getProfile();

      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUserProfile({required String name, String? photoUrl,}) async {
    final currentState = state;

    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.profile));
    }

    try {
      final profile = await updateProfile(
        name: name,
        photoUrl: photoUrl,
      );

      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

}