import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/camera_capture_button.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/flip_camera_button.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/gallery_picker_button.dart';

class CameraBottomControls extends StatelessWidget {
  const CameraBottomControls({
    super.key,
    required this.bottomBarHeight,
    required this.onCapture,
    this.onPickGallery,
    this.onSwitchCamera,
    this.isCapturing = false,
  });

  final double bottomBarHeight;
  final VoidCallback onCapture;
  final VoidCallback? onPickGallery;
  final VoidCallback? onSwitchCamera;
  final bool isCapturing;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: bottomBarHeight,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.85),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.w,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GalleryPickerButton(onTap: onPickGallery),
            CameraCaptureButton(
              onTap: onCapture,
              isCapturing: isCapturing,
            ),
            FlipCameraButton(onTap: onSwitchCamera),
          ],
        ),
      ),
    );
  }
}


