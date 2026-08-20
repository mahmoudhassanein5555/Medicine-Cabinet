import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/utils/cloudinary_service.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/profile_entity.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

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
  bool _isUploadingImage = false;

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

  // =====================================================
  // Pick Image
  // =====================================================

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) {
        return;
      }

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

  // =====================================================
  // Save Changes
  // =====================================================

  Future<void> _saveChanges() async {
    final l10n = S.of(context);
    final newName = _nameController.text.trim();

    // =========================
    // Validate Name
    // =========================

    if (newName.isEmpty) {
      AppToast.showToast(
        context: context,
        title: l10n.commonError,
        description: l10n.profileNameRequired,
        type: ToastificationType.warning,
      );

      return;
    }

    String? photoUrl;

    // =========================
    // Upload Image
    // =========================

    if (_selectedImage != null) {
      setState(() {
        _isUploadingImage = true;
      });

      try {
        photoUrl = await CloudinaryService.uploadImage(_selectedImage!);
      } catch (_) {
        photoUrl = null;
      }

      if (!mounted) return;

      setState(() {
        _isUploadingImage = false;
      });

      if (photoUrl == null) {
        AppToast.showToast(
          context: context,
          title: l10n.commonError,
          description: l10n.profileImageUploadFailed,
          type: ToastificationType.error,
        );

        return;
      }
    }

    // =========================
    // Update Profile
    // =========================

    await context.read<ProfileCubit>().updateUserProfile(
      name: newName,
      photoUrl: photoUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profilePersonalInformationTitle)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        // =====================================================
        // Listener
        // =====================================================
        listener: (context, state) {
          final l10n = S.of(context);

          // =========================
          // Update Success
          // =========================

          if (state is ProfileLoaded) {
            AppToast.showToast(
              context: context,
              title: l10n.commonSuccess,
              description: l10n.profileUpdateSuccess,
              type: ToastificationType.success,
            );

            Navigator.pop(context);
            return;
          }

          // =========================
          // Update Error
          // =========================

          if (state is ProfileError) {
            AppToast.showToast(
              context: context,
              title: l10n.commonError,
              description: ErrorLocalization.getMessage(
                state.message,
                l10n,
              ),
              type: ToastificationType.error,
            );
          }
        },

        // =====================================================
        // Builder
        // =====================================================
        builder: (context, state) {
          final isSaving = state is ProfileUpdating || _isUploadingImage;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =====================================================
                // Profile Picture
                // =====================================================
                Center(
                  child: GestureDetector(
                    onTap: isSaving ? null : _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : widget.profile.photoUrl != null
                              ? NetworkImage(widget.profile.photoUrl!)
                              : null,
                          child:
                              _selectedImage == null &&
                                  widget.profile.photoUrl == null
                              ? Text(
                                  widget.profile.name.isNotEmpty
                                      ? widget.profile.name[0].toUpperCase()
                                      : 'U',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                )
                              : null,
                        ),

                        // Camera button
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 19,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),

                        // Upload loading
                        if (_isUploadingImage)
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // =====================================================
                // Full Name
                // =====================================================
                Text(
                  l10n.profileFullName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextFormField(
                  controller: _nameController,
                  hintText: l10n.profileFullName,
                  keyboardType: TextInputType.name,
                  enabled: !isSaving,
                ),

                const SizedBox(height: 20),

                // =====================================================
                // Email
                // =====================================================
                Text(
                  l10n.profileEmailAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextFormField(
                  controller: _emailController,
                  hintText: l10n.profileEmailAddress,
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                ),

                const SizedBox(height: 35),

                // =====================================================
                // Save Button
                // =====================================================
                CustomButton(
                  text: isSaving
                      ? l10n.profileSavingChanges
                      : l10n.profileSaveChanges,
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
