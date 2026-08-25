import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 22.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive
                ? colorScheme.primary
                : colorScheme.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
