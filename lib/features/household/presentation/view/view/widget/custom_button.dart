import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;

    final textStyle = TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    );

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: 52.h,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isEnabled ? colorScheme.primary : colorScheme.outline,
              width: 1.8.w,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: Text(
            text,
            style: textStyle.copyWith(
              color: isEnabled ? colorScheme.primary : colorScheme.outline,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          text,
          style: textStyle.copyWith(color: colorScheme.onPrimary),
        ),
      ),
    );
  }
}
