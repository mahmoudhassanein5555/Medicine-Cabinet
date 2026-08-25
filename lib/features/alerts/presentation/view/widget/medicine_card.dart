import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/alert_medicine_image.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/alert_status_badge.dart';

import '../../../../../generated/l10n.dart';
import '../../../domain/entity/medicine_entity.dart';

class MedicineCard extends StatelessWidget {
  final MedicineEntity medicine;
  final VoidCallback? onTap;

  const MedicineCard({super.key, required this.medicine, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEAF1EE),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AlertMedicineImage(imageUrl: medicine.imageUrl),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        medicine.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        '${medicine.type.isNotEmpty ? '${medicine.type} · ' : ''}${l10n.medicineQuantity(medicine.quantity)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                AlertStatusBadge(medicine: medicine),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
