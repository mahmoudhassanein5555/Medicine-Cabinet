import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.all_inbox_rounded,
            color: colorScheme.primary,
            size: 30.r,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}