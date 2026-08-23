import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class HomeHeaderWidget extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onMenuPressed;

  const HomeHeaderWidget({
    super.key,
    required this.user,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final userName = user.firstName.isNotEmpty
        ? user.firstName
        : S.of(context).commonUser;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).welcomeBack,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                " $userName 🤗",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                S.of(context).homeSubtitle,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : const Color(0xFF6C7A76),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onMenuPressed,
          child: Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primaryDarkVariant
                  : AppColors.primaryLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (isDark ? AppColors.primaryDark : AppColors.primaryLight)
                      .withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: user.photoUrl.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.photoUrl,
                      width: 48.r,
                      height: 48.r,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => _buildInitial(),
                    ),
                  )
                : _buildInitial(),
          ),
        ),
      ],
    );
  }

  Widget _buildInitial() {
    return Text(
      user.initial,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
