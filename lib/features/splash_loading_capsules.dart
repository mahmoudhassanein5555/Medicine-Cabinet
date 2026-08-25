import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLoadingCapsules extends StatefulWidget {
  const SplashLoadingCapsules({super.key, required this.color});

  final Color color;

  @override
  State<SplashLoadingCapsules> createState() => _SplashLoadingCapsulesState();
}

class _SplashLoadingCapsulesState extends State<SplashLoadingCapsules>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final delay = index * 0.15 / 1.2;
        final interval = Interval(
          delay.clamp(0.0, 1.0),
          (delay + 0.7).clamp(0.0, 1.0),
          curve: Curves.easeInOut,
        );
        final anim = CurvedAnimation(parent: _controller, curve: interval);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w),
          child: AnimatedBuilder(
            animation: anim,
            builder: (context, _) {
              final t = (1 - (anim.value - 0.5).abs() * 2).clamp(0.0, 1.0);
              return Opacity(
                opacity: 0.3 + 0.7 * t,
                child: Transform.scale(
                  scaleY: 1 + 0.35 * t,
                  child: Container(
                    width: 9.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
