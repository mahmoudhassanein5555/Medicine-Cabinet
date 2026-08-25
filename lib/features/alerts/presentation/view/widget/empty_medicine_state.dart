import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class EmptyMedicineState extends StatelessWidget {
  const EmptyMedicineState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180.r,
              height: 180.r,
              child: Lottie.asset(
                AppAssets.nodata,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              S.of(context).medicineNoMedicines,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}