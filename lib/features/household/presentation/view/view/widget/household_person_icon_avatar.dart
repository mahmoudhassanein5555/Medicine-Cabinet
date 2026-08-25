import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseholdPersonIconAvatar extends StatelessWidget {
  const HouseholdPersonIconAvatar({
    super.key,
    required this.radius,
    required this.colorScheme,
  });

  final double radius;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: colorScheme.primary,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: (radius * 1.1).r,
      ),
    );
  }
}
