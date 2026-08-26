import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerTopBar extends StatelessWidget {
  const ScannerTopBar({
    super.key,
    required this.title,
    required this.onClose,
    required this.onToggleTorch,
    required this.torchState,
    required this.isJoining,
  });

  final String title;
  final VoidCallback onClose;
  final VoidCallback onToggleTorch;
  final TorchState torchState;
  final bool isJoining;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 14.h,
        ),
        child: Row(
          children: [
            _CircleButton(
              icon: Icons.close,
              onTap: isJoining ? null : onClose,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            _CircleButton(
              icon: torchState == TorchState.on
                  ? Icons.flash_on
                  : Icons.flash_off,
              onTap: onToggleTorch,
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.r,
        height: 50.r,
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 25.r,
        ),
      ),
    );
  }
}