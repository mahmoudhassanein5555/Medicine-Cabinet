import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicinesError extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const MedicinesError({super.key, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
        child: Column(
          children: [
            Lottie.asset(
              AppAssets.errorAnimation,
              width: 200.r,
              height: 200.r,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 16.h),

            Text(
              message ?? l10n.commonSomethingWentWrong,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              l10n.commonTryAgain,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
              ),
            ),

            if (onRetry != null) ...[
              SizedBox(height: 20.h),

              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh_rounded, size: 20.r),
                label: Text(l10n.commonRetry, style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
