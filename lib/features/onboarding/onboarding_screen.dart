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
    final colorScheme = Theme.of(context).colorScheme;
    final pages = getOnboardingPages(context);
    final bool isLastPage = _page == pages.length - 1;
    final s = S.of(context);

    void next() {
      if (isLastPage) {
        widget.onFinished?.call(context);
        return;
      }
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) =>
                    OnboardingPageView(data: pages[index]),
              ),
            ),
            OnboardingDotIndicator(count: pages.length, activeIndex: _page),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    isLastPage ? s.onboardingGetStarted : s.onboardingContinue,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () => widget.onFinished?.call(context),
              child: Text(
                s.onboardingSkip,
                style: TextStyle(
                  color: isLastPage
                      ? Colors.transparent
                      : AppColors.scannerFrameAccent,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}