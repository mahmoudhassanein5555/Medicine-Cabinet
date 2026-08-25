import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({
    super.key,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.showDivider = true,
    this.color,
  });

  final String title;
  final VoidCallback onTap;
  final String? trailingText;
  final bool showDivider;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 4.h,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          trailing: trailingText != null
              ? Text(
                  trailingText!,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13.sp,
                  ),
                )
              : Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  size: 24.r,
                ),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.8,
            indent: 16.w,
            endIndent: 16.w,
            color: colorScheme.outline,
          ),
      ],
    );
  }
}