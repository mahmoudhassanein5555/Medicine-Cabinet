import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: Image.asset(
          'assets/icons/google_logo.png',
          width: 30.r,
          height: 30.r,
        ),
        label: Text(
          l10n.authContinueWithGoogle,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          side: BorderSide(
            color: colorScheme.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.r),
          ),
        ),
      ),
    );
  }
}