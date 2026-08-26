import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScannerOverlayPainter(),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;

    final frameSize = size.width * 0.78;

    final left = (size.width - frameSize) / 2;
    final top = (size.height - frameSize) / 2;

    final frameRect = Rect.fromLTWH(
      left,
      top,
      frameSize,
      frameSize,
    );

    final overlayPath = Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          frameRect,
          Radius.circular(25.r),
        ),
      );

    canvas.drawPath(overlayPath, paint);

    final borderPaint = Paint()
      ..color = AppColors.scannerFrameAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final cornerLength = 35.r;

    canvas.drawLine(
      Offset(left, top + cornerLength),
      Offset(left, top),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left, top),
      Offset(left + cornerLength, top),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left + frameSize - cornerLength, top),
      Offset(left + frameSize, top),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left + frameSize, top),
      Offset(left + frameSize, top + cornerLength),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left, top + frameSize - cornerLength),
      Offset(left, top + frameSize),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left, top + frameSize),
      Offset(left + cornerLength, top + frameSize),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left + frameSize - cornerLength, top + frameSize),
      Offset(left + frameSize, top + frameSize),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left + frameSize, top + frameSize - cornerLength),
      Offset(left + frameSize, top + frameSize),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}