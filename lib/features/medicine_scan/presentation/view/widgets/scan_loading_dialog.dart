import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class ScanLoadingDialog extends StatelessWidget {
  const ScanLoadingDialog({super.key, this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => const ScanLoadingDialog(),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displayTitle = title ?? S.of(context).scanAnalyzingTitle;
    final displaySubtitle = subtitle ?? S.of(context).scanAnalyzingSubtitle;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 110.h,
            width: 110.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(12.r),
            child: Lottie.asset(
              'assets/animations/loading.json',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.auto_awesome_rounded,
                size: 48.r,
                color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            displayTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            displaySubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
              letterSpacing: 0.2,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
