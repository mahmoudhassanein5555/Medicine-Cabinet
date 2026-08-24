import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class CameraTopBar extends StatelessWidget {
  const CameraTopBar({
    super.key,
    this.isFlashOn = false,
    this.onToggleFlash,
    this.onClose,
  });

  final bool isFlashOn;
  final VoidCallback? onToggleFlash;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 10.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleIconButton(
            icon: Icons.close_rounded,
            onTap: onClose ?? () => Navigator.maybePop(context),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt_rounded, size: 16.r, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  S.of(context).scanMedicineTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _buildCircleIconButton(
            icon: isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
            iconColor: isFlashOn ? Colors.amber : Colors.white,
            onTap: onToggleFlash,
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    Color iconColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.w,
            ),
          ),
          child: Center(child: Icon(icon, size: 22.r, color: iconColor)),
        ),
      ),
    );
  }
}

