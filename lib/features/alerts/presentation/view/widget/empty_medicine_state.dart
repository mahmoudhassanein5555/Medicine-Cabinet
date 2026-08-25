import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyMedicineState extends StatelessWidget {
  const EmptyMedicineState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: SizedBox(
          width: double.infinity,
          height: 250.h,
          child: Lottie.asset(
            'assets/animations/empty.json',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}