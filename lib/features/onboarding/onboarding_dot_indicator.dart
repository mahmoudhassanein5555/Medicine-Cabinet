import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 24.w : 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: isActive
                ? (isDark ? AppColors.primaryDark : const Color(0xFF1B4D3E))
                : (isDark ? Colors.white24 : const Color(0xFFD6E4DF)),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
