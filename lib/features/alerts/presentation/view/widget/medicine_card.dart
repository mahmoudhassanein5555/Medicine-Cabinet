import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/alert_medicine_image.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view/widget/alert_status_badge.dart';

import '../../../../../generated/l10n.dart';
import '../../../domain/entity/medicine_entity.dart';

class MedicineCard extends StatelessWidget {
  final MedicineEntity medicine;

  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AlertMedicineImage(imageUrl: medicine.imageUrl),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  medicine.type,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  l10n.medicineQuantity(medicine.quantity),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AlertStatusBadge(medicine: medicine),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
