import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
    this.role,
    required this.profileImage,
    required this.id,
  });

  final String name;
  final String profileImage;
  final String id;
  final bool isSelected;
  final VoidCallback onTap;
  final String? role;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isSelected
        ? primaryColor
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 88.w,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: isDark ? 0.25 : 0.1)
              : cardBg,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.w : 1.2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? primaryColor.withValues(alpha: 0.25)
                  : (isDark
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.03)),
              blurRadius: isSelected ? 10.r : 6.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: primaryColor.withValues(alpha: 0.2),
                  child: profileImage.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            profileImage,
                            width: 40.r,
                            height: 40.r,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person_rounded,
                              size: 20.r,
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.person_rounded,
                          size: 20.r,
                          color: primaryColor,
                        ),
                ),
                if (isSelected)
                  Positioned(
                    right: -2.w,
                    bottom: -2.h,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 10.r,
                        color: isDark ? AppColors.backgroundDark : Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? (isDark ? Colors.white : primaryColor)
                    : (isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
