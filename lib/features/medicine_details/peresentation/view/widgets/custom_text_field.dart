import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String labelText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 13.sp),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}
