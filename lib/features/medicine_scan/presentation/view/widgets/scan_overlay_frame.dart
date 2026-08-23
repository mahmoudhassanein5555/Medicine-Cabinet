import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/scanner_corner_accents.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class ScanOverlayFrame extends StatefulWidget {
  const ScanOverlayFrame({
    super.key,
    required this.bottomBarHeight,
  });

  final double bottomBarHeight;

  @override
  State<ScanOverlayFrame> createState() => _ScanOverlayFrameState();
}

class _ScanOverlayFrameState extends State<ScanOverlayFrame>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _scanAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final frameWidth = screenSize.width * 0.86;
    final frameHeight = screenSize.height * 0.48;

    return Stack(
      children: [
        Positioned.fill(
          bottom: widget.bottomBarHeight,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.55),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: frameWidth,
                      height: frameHeight,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: widget.bottomBarHeight,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: frameWidth,
              height: frameHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5.w,
                ),
              ),
              child: Stack(
                children: [
                  const ScannerCornerAccents(),
                  AnimatedBuilder(
                    animation: _scanAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: 20.h + (_scanAnimation.value * (frameHeight - 44.h)),
                        left: 16.w,
                        right: 16.w,
                        child: Container(
                          height: 2.5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.r),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.scannerFrameAccent.withValues(alpha: 0.0),
                                AppColors.scannerFrameAccent,
                                AppColors.scannerFrameAccent.withValues(alpha: 0.0),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.scannerFrameAccent.withValues(alpha: 0.6),
                                blurRadius: 10.r,
                                spreadRadius: 1.5.r,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 70.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.crop_free_rounded,
                    size: 16.r,
                    color: AppColors.scannerFrameAccent,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    S.of(context).scanHintAlignBox,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


