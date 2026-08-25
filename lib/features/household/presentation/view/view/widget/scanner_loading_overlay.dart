import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ScannerLoadingOverlay extends StatelessWidget {
  const ScannerLoadingOverlay({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Colors.black.withValues(alpha: 0.55),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 110.w,
                height: 110.h,
                child: Lottie.asset(
                  'assets/animations/loading.json',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      width: 45.r,
                      height: 45.r,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}