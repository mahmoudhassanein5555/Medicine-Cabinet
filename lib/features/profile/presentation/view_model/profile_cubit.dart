import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/utils/cloudinary_service.dart';

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
      final failure = ErrorHandler.handle(e);
      emit(ProfileError(failure));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    String? photoUrl,
    File? imageFile,
  }) async {
    final currentState = state;

    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.profile));
    }

    try {
      String? resolvedPhotoUrl = photoUrl;
      if (imageFile != null) {
        resolvedPhotoUrl = await CloudinaryService.uploadImage(imageFile);
      }

      final profile = await updateProfile(
        name: name,
        photoUrl: resolvedPhotoUrl,
      );

      emit(ProfileUpdateSuccess(profile));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(ProfileError(failure));
    }
  }
}