import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'onboarding_page_data.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 270.r,
            height: 270.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.black : const Color(0xFF28856F))
                      .withValues(alpha: 0.12),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.r),
              child: Image.asset(
                data.imageAsset,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 36.h),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24.sp,
              color: isDark ? Colors.white : const Color(0xFF1B4D3E),
              letterSpacing: -0.4,
              height: 1.2,
            ),
          ),
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              data.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : const Color(0xFF6C8A82),
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}