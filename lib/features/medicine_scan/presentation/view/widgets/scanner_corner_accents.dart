import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class ScannerCornerAccents extends StatelessWidget {
  const ScannerCornerAccents({super.key});

  @override
  Widget build(BuildContext context) {
    final double cornerSize = 24.0.w;
    final double cornerThickness = 3.5.w;
    final double radius = 24.0.r;
    const accentColor = AppColors.scannerFrameAccent;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: cornerSize,
            height: cornerSize,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: accentColor, width: cornerThickness),
                left: BorderSide(color: accentColor, width: cornerThickness),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: cornerSize,
            height: cornerSize,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: accentColor, width: cornerThickness),
                right: BorderSide(color: accentColor, width: cornerThickness),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: cornerSize,
            height: cornerSize,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: accentColor, width: cornerThickness),
                left: BorderSide(color: accentColor, width: cornerThickness),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: cornerSize,
            height: cornerSize,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: accentColor, width: cornerThickness),
                right: BorderSide(color: accentColor, width: cornerThickness),
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
