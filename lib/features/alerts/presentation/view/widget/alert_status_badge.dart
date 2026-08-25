import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/alerts/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class AlertStatusBadge extends StatelessWidget {
  final MedicineEntity medicine;

  const AlertStatusBadge({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    late final String text;
    late final Color color;
    late final Color bgColor;

    if (medicine.isExpired) {
      text = l10n.medicineStatusExpired;
      color = isDark ? AppColors.errorDark : AppColors.errorLight;
      bgColor = isDark
          ? AppColors.errorDark.withValues(alpha: 0.15)
          : AppColors.errorContainerLight;
    } else if (medicine.isEnded) {
      text = l10n.medicineStatusEnded;
      color = isDark ? AppColors.warningDark : AppColors.warningLight;
      bgColor = isDark
          ? AppColors.warningDark.withValues(alpha: 0.15)
          : AppColors.warningContainerLight;
    } else {
      text = l10n.medicineStatusValid;
      color = isDark ? AppColors.successDark : AppColors.successLight;
      bgColor = isDark
          ? AppColors.successDark.withValues(alpha: 0.15)
          : AppColors.successContainerLight;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.5.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
