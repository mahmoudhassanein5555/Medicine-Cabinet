import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
          offset: Offset(0, 10 * (1 - anim.value)),
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
    final brightness = Theme.of(context).brightness;
    final lottieAsset = brightness == Brightness.dark
        ? 'assets/images/splash_cabinet_dark.json'
        : 'assets/images/splash_cabinet_light.json';

    final s = S.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset(
                lottieAsset,
                controller: _controller,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            _riseIn(
              startS: 2.1,
              endS: 2.7,
              child: Text(
                s.splashWordmark,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _riseIn(
              startS: 2.3,
              endS: 2.9,
              child: Text(
                s.splashTagline,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 34),
            _riseIn(
              startS: 2.6,
              endS: 3.1,
              child: Column(
                children: [
                  _LoadingCapsules(color: colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(
                    s.splashLoadingText,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.45),
                      fontSize: 14,
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

class _LoadingCapsules extends StatefulWidget {
  const _LoadingCapsules({required this.color});

  final Color color;

  @override
  State<_LoadingCapsules> createState() => _LoadingCapsulesState();
}

class _LoadingCapsulesState extends State<_LoadingCapsules>
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
          padding: const EdgeInsets.symmetric(horizontal: 3.5),
          child: AnimatedBuilder(
            animation: anim,
            builder: (context, _) {
              final t = (1 - (anim.value - 0.5).abs() * 2).clamp(0.0, 1.0);
              return Opacity(
                opacity: 0.3 + 0.7 * t,
                child: Transform.scale(
                  scaleY: 1 + 0.35 * t,
                  child: Container(
                    width: 9,
                    height: 16,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(6),
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
