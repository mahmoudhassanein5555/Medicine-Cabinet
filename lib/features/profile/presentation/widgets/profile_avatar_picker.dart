import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/profile/domain/entities/profile_entity.dart';

class ProfileAvatarPicker extends StatelessWidget {
  final ProfileEntity profile;
  final File? selectedImage;
  final bool isSaving;
  final VoidCallback onPickImage;

  const ProfileAvatarPicker({
    super.key,
    required this.profile,
    required this.selectedImage,
    required this.isSaving,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: GestureDetector(
        onTap: isSaving ? null : onPickImage,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 55.r,
              backgroundColor: colorScheme.primary,
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : profile.photoUrl != null
                      ? NetworkImage(profile.photoUrl!)
                      : null,
              child: selectedImage == null && profile.photoUrl == null
                  ? Text(
                      profile.name.isNotEmpty
                          ? profile.name[0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 19.r,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            if (isSaving)
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
    );
  }
}
