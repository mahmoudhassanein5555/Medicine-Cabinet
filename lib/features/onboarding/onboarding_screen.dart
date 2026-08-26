import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/onboarding/onboarding_dot_indicator.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

import 'onboarding_page_data.dart';
import 'onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.onFinished});

  final void Function(BuildContext context)? onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pages = getOnboardingPages(context);
    final bool isLastPage = _page == pages.length - 1;
    final s = S.of(context);
    final primaryColor = isDark ? AppColors.primaryDark : const Color(0xFF1B4D3E);

    void next() {
      if (isLastPage) {
        widget.onFinished?.call(context);
        return;
      }
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFAFCFB),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  if (!isLastPage)
                    TextButton(
                      onPressed: () => widget.onFinished?.call(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        s.onboardingSkip,
                        style: TextStyle(
                          color: isDark ? AppColors.primaryDark : const Color(0xFF28856F),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) =>
                    OnboardingPageView(data: pages[index]),
              ),
            ),

            // Dots Indicator
            SizedBox(height: 16.h),
            OnboardingDotIndicator(count: pages.length, activeIndex: _page),
            SizedBox(height: 24.h),

            // Action Button (Continue / Get Started)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                width: double.infinity,
                height: 54.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    isLastPage ? s.onboardingGetStarted : s.onboardingContinue,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}