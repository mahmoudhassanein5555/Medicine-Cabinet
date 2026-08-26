import 'package:flutter/material.dart';
import 'package:medicine_cabinet/core/constants/app_assets.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  final String imageAsset;
  final String title;
  final String description;
}

List<OnboardingPageData> getOnboardingPages(BuildContext context) {
  final s = S.of(context);
  return [
    OnboardingPageData(
      imageAsset: AppAssets.onboarding1,
      title: s.onboardingTitle1,
      description: s.onboardingDesc1,
    ),
    OnboardingPageData(
      imageAsset: AppAssets.onboarding2,
      title: s.onboardingTitle2,
      description: s.onboardingDesc2,
    ),
    OnboardingPageData(
      imageAsset: AppAssets.onboarding3,
      title: s.onboardingTitle3,
      description: s.onboardingDesc3,
    ),
  ];
}