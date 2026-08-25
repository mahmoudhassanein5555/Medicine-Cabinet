import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineIcon extends StatelessWidget {
  const MedicineIcon({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.w,
      height: 14.h,
      child: CustomPaint(painter: CapsulePainter(color: color)),
    );
  }
}

class CapsulePainter extends CustomPainter {
  const CapsulePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
      Radius.circular(size.height),
    );

    canvas.drawRRect(rect, paint);

    canvas.drawLine(
      Offset(size.width / 2, 1.5),
      Offset(size.width / 2, size.height - 1.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CapsulePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
