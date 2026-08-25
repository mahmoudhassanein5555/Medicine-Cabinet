import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSwitchTile extends StatelessWidget {
  const ProfileSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: value,
                activeThumbColor: colorScheme.primary,
                onChanged: onChanged,
              ),
            ],
          ),
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
