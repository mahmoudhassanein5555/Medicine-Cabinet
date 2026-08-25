import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
  });

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final firstLetter = profile.name.trim().isNotEmpty
        ? profile.name.trim()[0].toUpperCase()
        : '?';

    return Row(
      children: [
        CircleAvatar(
          radius: 36.r,
          backgroundColor: colorScheme.primary,
          backgroundImage: profile.photoUrl != null &&
                  profile.photoUrl!.isNotEmpty
              ? NetworkImage(profile.photoUrl!)
              : null,
          child: profile.photoUrl == null || profile.photoUrl!.isEmpty
              ? Text(
                  firstLetter,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                profile.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}