import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/household_local_data_source.dart';
import '../../../../generated/l10n.dart';
import '../../../household/presentation/view/view/household_qr_code.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
  });

  final ProfileEntity profile;
  void _showHouseholdQrDialog(BuildContext context) {
    final l10n = S.of(context);
    final householdId =
    getIt<HouseholdLocalDataSource>().getHouseholdId();

    if (householdId == null || householdId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.householdQrNotMember),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n.householdQrTitle,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HouseholdQrCode(
                householdId: householdId,
              ),

              SizedBox(height: 16.h),

              Text(
                l10n.householdQrDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 10.h),


              Text(
                householdId,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }



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
        IconButton(
          onPressed: () => _showHouseholdQrDialog(context),
          icon: Icon(
            Icons.qr_code_2,
            size: 30.r,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}