import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/household_expiry_badge.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/household_medicine_image.dart';

import '../../../../domain/entity/medicine_entity.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.medicine});

  final MedicineEntity medicine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final expiry = medicine.expiryDate;
    final expiryText =
        expiry != null ? '${_monthName(expiry.month)} ${expiry.year}' : '-';

    final isExpired = medicine.isExpired;
    final hasExpiryInfo = expiry != null;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isExpired
              ? Colors.red.withValues(alpha: 0.4)
              : colorScheme.outline,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HouseholdMedicineImage(
            imageUrl: medicine.imageUrl,
            colorScheme: colorScheme,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    Text(
                      medicine.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    if (hasExpiryInfo)
                      HouseholdExpiryBadge(isExpired: isExpired),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  'Qty: ${medicine.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Expiry: $expiryText',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isExpired ? Colors.red : colorScheme.onSurfaceVariant,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colorScheme.onSurfaceVariant,
            size: 24.r,
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return names[month - 1];
  }
}