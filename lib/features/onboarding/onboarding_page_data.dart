import 'package:flutter/material.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.iconAsset,
    required this.title,
    required this.description,
  });

  final String iconAsset;
  final String title;
  final String description;
}

List<OnboardingPageData> getOnboardingPages(BuildContext context) {
  final s = S.of(context);
  return [
    OnboardingPageData(
      iconAsset: 'assets/icons/onboarding_organize.svg',
      title: s.onboardingTitle1,
      description: s.onboardingDesc1,
    ),
    OnboardingPageData(
      iconAsset: 'assets/icons/onboarding_reminder.svg',
      title: s.onboardingTitle2,
      description: s.onboardingDesc2,
    ),
    OnboardingPageData(
      iconAsset: 'assets/icons/onboarding_check.svg',
      title: s.onboardingTitle3,
      description: s.onboardingDesc3,
    ),
  ];
}