import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineDetailsError extends StatelessWidget {
  final Failure? failure;
  final String? message;
  final VoidCallback onRetry;

  const MedicineDetailsError({
    super.key,
    this.failure,
    this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = S.of(context);

    final errorText = failure?.getMessage(context) ??
        message ??
        s.commonUnableToLoadMedicineDetails;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 220.h,
              child: Lottie.asset(AppAssets.errorAnimation, repeat: true),
            ),

            SizedBox(height: 20.h),

            Text(
              s.commonSomethingWentWrong,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              errorText,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 24.h),

            FilledButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: 18.r),
              label: Text(
                s.commonRetry,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
