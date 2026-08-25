import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class MedicineStatusBadge extends StatelessWidget {
  const MedicineStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isHealthy = status == 'Healthy';

    final Color backgroundColor = isHealthy
        ? (isDark
            ? AppColors.successDark.withValues(alpha: 0.15)
            : AppColors.successContainerLight)
        : (isDark
            ? AppColors.warningDark.withValues(alpha: 0.15)
            : AppColors.warningContainerLight);

    final Color textColor = isHealthy
        ? (isDark ? AppColors.successDark : AppColors.successLight)
        : (isDark ? AppColors.warningDark : AppColors.warningLight);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Text(
        status,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
