import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class EmptyMedicines extends StatelessWidget {
  const EmptyMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 20.h),
        child: Column(
          children: [
            Lottie.asset(
              AppAssets.nodata,
              width: 250.r,
              height: 250.r,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 12.h),

            Text(
              l10n.medicinesNoMedicines,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
