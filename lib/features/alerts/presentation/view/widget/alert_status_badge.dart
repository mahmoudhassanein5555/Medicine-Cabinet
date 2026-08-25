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
    final theme = Theme.of(context);

    late final String text;
    late final Color color;

    if (medicine.isExpired) {
      text = l10n.medicineStatusExpired;
      color = Colors.red;
    } else if (medicine.isEnded) {
      text = l10n.medicineStatusEnded;
      color = AppColors.warningLight;
    } else {
      text = l10n.medicineStatusValid;
      color = Colors.green;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
