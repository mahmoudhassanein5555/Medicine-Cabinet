import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized Typography Scale for Medicine Cabinet
///
/// Standard Hierarchy:
/// - Display / Hero: 26.sp - 28.sp (w800 / Bold)
/// - Screen Title: 22.sp - 24.sp (w800 / Bold)
/// - AppBar Title: 18.sp (w700 / Bold)
/// - Section Title: 16.sp - 18.sp (w800 / Bold)
/// - Card Title: 15.sp - 16.sp (w700 / Bold)
/// - Body Text: 14.sp (w600 / Regular)
/// - Secondary / Meta: 12.sp - 13.sp (w400 / w500)
/// - Caption / Badge: 10.5.sp - 11.sp (w700 / w800)
/// - Button Text: 16.sp (w700)
class AppTypography {
  AppTypography._();

  // Font Sizes
  static double get displayHero => 26.sp;
  static double get screenTitle => 24.sp;
  static double get screenTitleSmall => 22.sp;
  static double get appBarTitle => 18.sp;
  static double get sectionTitle => 18.sp;
  static double get sectionTitleSmall => 16.sp;
  static double get cardTitle => 16.sp;
  static double get cardTitleSmall => 15.sp;
  static double get body => 14.sp;
  static double get bodySecondary => 13.sp;
  static double get caption => 12.sp;
  static double get badge => 11.sp;
  static double get button => 16.sp;
}
