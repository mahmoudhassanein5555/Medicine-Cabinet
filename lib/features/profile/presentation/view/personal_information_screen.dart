import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_cabinet/core/dialogs/app_toasts.dart';
import 'package:medicine_cabinet/core/widgets/custom_button.dart';
import 'package:medicine_cabinet/core/widgets/custom_text_form_field.dart';
import 'package:medicine_cabinet/features/profile/domain/entities/profile_entity.dart';
import 'package:medicine_cabinet/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/view_model/profile_state.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_avatar_picker.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class PersonalInformationScreen extends StatefulWidget {
  final ProfileEntity profile;

  const PersonalInformationScreen({super.key, required this.profile});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      setState(() {
        _selectedImage = File(image.path);
      });
    } catch (e) {
      if (!mounted) return;
      final l10n = S.of(context);
      AppToast.showToast(
        context: context,
        title: l10n.commonError,
        description: l10n.profileImageUploadFailed,
        type: ToastificationType.error,
      );
    }
  }

  Future<void> _saveChanges() async {
    final l10n = S.of(context);
    final newName = _nameController.text.trim();

    if (newName.isEmpty) {
      AppToast.showToast(
        context: context,
        title: l10n.commonError,
        description: l10n.profileNameRequired,
        type: ToastificationType.warning,
      );
      return;
    }

    await context.read<ProfileCubit>().updateUserProfile(
      name: newName,
      imageFile: _selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profilePersonalInformationTitle,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          final l10n = S.of(context);

          if (state is ProfileUpdateSuccess) {
            AppToast.showToast(
              context: context,
              title: l10n.commonSuccess,
              description: l10n.profileUpdateSuccess,
              type: ToastificationType.success,
            );
            Navigator.pop(context);
            return;
          }

          if (state is ProfileError) {
            AppToast.showToast(
              context: context,
              title: l10n.commonError,
              description: state.failure.getMessage(context),
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          final isSaving = state is ProfileUpdating;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAvatarPicker(
                  profile: widget.profile,
                  selectedImage: _selectedImage,
                  isSaving: isSaving,
                  onPickImage: _pickImage,
                ),

                SizedBox(height: 35.h),

                Text(
                  l10n.profileFullName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                CustomTextFormField(
                  controller: _nameController,
                  hintText: l10n.profileFullName,
                  keyboardType: TextInputType.name,
                  enabled: !isSaving,
                ),

                SizedBox(height: 20.h),

                Text(
                  l10n.profileEmailAddress,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                CustomTextFormField(
                  controller: _emailController,
                  hintText: l10n.profileEmailAddress,
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                ),

                SizedBox(height: 35.h),

                CustomButton(
                  text: isSaving
                      ? l10n.profileSavingChanges
                      : l10n.profileSaveChanges,
                  isLoading: isSaving,
                  onPressed: _saveChanges,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
