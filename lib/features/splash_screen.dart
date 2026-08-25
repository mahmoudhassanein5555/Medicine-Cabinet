import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/features/splash_loading_capsules.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.resolveInitialRoute,
    required this.onNavigate,
  });

  final Future<String> Function() resolveInitialRoute;
  final void Function(BuildContext context, String route) onNavigate;

  static const Duration totalDuration = Duration(milliseconds: 4200);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  String? _resolvedRoute;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SplashScreen.totalDuration,
    )..forward();

    widget.resolveInitialRoute().then((route) => _resolvedRoute = route);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        widget.onNavigate(context, _resolvedRoute ?? '/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _riseIn({
    required double startS,
    required double endS,
    required Widget child,
  }) {
    final interval = Interval(startS / 4.2, endS / 4.2, curve: Curves.easeIn);
    final anim = CurvedAnimation(parent: _controller, curve: interval);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, _) => Opacity(
        opacity: anim.value,
        child: Transform.translate(
          offset: Offset(0, 10.h * (1 - anim.value)),
          child: child,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250.r,
              height: 250.r,
              child: Lottie.asset(
                AppAssets.splashAnimation,
                controller: _controller,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.h),
            _riseIn(
              startS: 2.1,
              endS: 2.7,
              child: Text(
                s.splashWordmark,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 28.sp,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            _riseIn(
              startS: 2.3,
              endS: 2.9,
              child: Text(
                s.splashTagline,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 34.h),
            _riseIn(
              startS: 2.6,
              endS: 3.1,
              child: Column(
                children: [
                  SplashLoadingCapsules(color: colorScheme.primary),
                  SizedBox(height: 12.h),
                  Text(
                    s.splashLoadingText,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.45),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
