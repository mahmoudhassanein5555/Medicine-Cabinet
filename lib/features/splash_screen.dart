import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.resolveInitialRoute,
    required this.onNavigate,
  });

  final Future<String> Function() resolveInitialRoute;
  final void Function(BuildContext context, String route) onNavigate;

  static const Duration totalDuration = Duration(milliseconds: 2800);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  String? _resolvedRoute;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SplashScreen.totalDuration,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    widget.resolveInitialRoute().then((route) => _resolvedRoute = route);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        widget.onNavigate(context, _resolvedRoute ?? 'login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFAFCFB),
      body: Stack(
        children: [
          // Background soft gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          AppColors.backgroundDark,
                          const Color(0xFF0F1B17),
                        ]
                      : [
                          const Color(0xFFFFFFFF),
                          const Color(0xFFF2F9F5),
                          const Color(0xFFE5F4EC),
                        ],
                ),
              ),
            ),
          ),

          // Center content: Logo + Title + Subtitle
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150.r,
                      height: 150.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF28856F).withValues(alpha: 0.18),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32.r),
                        child: Image.asset(
                          AppAssets.splashLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      s.splashWordmark,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF1B4D3E),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      s.splashTagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : const Color(0xFF6C8A82),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Loading Spinner
          Positioned(
            bottom: 48.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: SizedBox(
                  width: 26.r,
                  height: 26.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.8,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? AppColors.primaryDark : const Color(0xFF2B8C74),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
