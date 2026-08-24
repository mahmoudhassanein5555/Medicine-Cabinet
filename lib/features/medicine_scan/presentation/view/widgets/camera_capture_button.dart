import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class CameraCaptureButton extends StatefulWidget {
  const CameraCaptureButton({
    super.key,
    required this.onTap,
    this.isCapturing = false,
  });

  final VoidCallback onTap;
  final bool isCapturing;

  @override
  State<CameraCaptureButton> createState() => _CameraCaptureButtonState();
}

class _CameraCaptureButtonState extends State<CameraCaptureButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        if (!widget.isCapturing) widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 16.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          padding: EdgeInsets.all(4.r),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isCapturing
                  ? AppColors.scannerFrameAccent
                  : Colors.white,
            ),
            child: widget.isCapturing
                ? Center(
                    child: SizedBox(
                      width: 28.w,
                      height: 28.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.black87,
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      height: 54.h,
                      width: 54.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.1),
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
