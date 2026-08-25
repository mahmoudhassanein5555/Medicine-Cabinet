import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'onboarding_page_data.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(data.iconAsset, width: 220.r, height: 220.r),
          SizedBox(height: 40.h),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 26.sp,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 15.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}