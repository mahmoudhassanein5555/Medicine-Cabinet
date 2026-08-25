import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseholdExpiryBadge extends StatelessWidget {
  const HouseholdExpiryBadge({super.key, required this.isExpired});

  final bool isExpired;

  @override
  Widget build(BuildContext context) {
    final color = isExpired ? Colors.red : Colors.green;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        isExpired ? 'Expired' : 'Valid',
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
