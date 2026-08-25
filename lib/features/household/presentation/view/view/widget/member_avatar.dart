import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/household_person_icon_avatar.dart';

class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.radius,
  });

  final String name;
  final String? photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;

    if (!hasPhoto) {
      return HouseholdPersonIconAvatar(radius: radius, colorScheme: colorScheme);
    }

    return ClipOval(
      child: Image.network(
        photoUrl!,
        width: (radius * 2).r,
        height: (radius * 2).r,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return CircleAvatar(
            radius: radius.r,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
            child: SizedBox(
              width: (radius * 0.7).r,
              height: (radius * 0.7).r,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            HouseholdPersonIconAvatar(radius: radius, colorScheme: colorScheme),
      ),
    );
  }
}