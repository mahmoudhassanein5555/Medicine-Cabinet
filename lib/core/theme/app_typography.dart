import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized Typography Scale for Medicine Cabinet (Balanced & Readable)
///
/// Standard Hierarchy:
/// - Display / Hero: 25.sp - 27.sp (w800 / Bold)
/// - Screen Title: 22.sp - 23.sp (w800 / Bold)
/// - AppBar Title: 17.sp - 18.sp (w700 / Bold)
/// - Section Title: 16.5.sp - 17.5.sp (w800 / Bold)
/// - Card Title: 15.sp - 15.5.sp (w700 / Bold)
/// - Body Text: 13.5.sp - 14.sp (w600 / Regular)
/// - Secondary / Meta: 12.sp - 12.5.sp (w400 / w500)
/// - Caption / Badge: 11.sp (w700 / w800)
/// - Button Text: 15.sp - 15.5.sp (w700)
class AppTypography {
  AppTypography._();

  // Font Sizes
  static double get displayHero => 26.sp;
  static double get screenTitle => 22.5.sp;
  static double get screenTitleSmall => 20.5.sp;
  static double get appBarTitle => 17.5.sp;
  static double get sectionTitle => 17.sp;
  static double get sectionTitleSmall => 15.5.sp;
  static double get cardTitle => 15.5.sp;
  static double get cardTitleSmall => 14.5.sp;
  static double get body => 13.5.sp;
  static double get bodySecondary => 12.5.sp;
  static double get caption => 11.5.sp;
  static double get badge => 10.5.sp;
  static double get button => 15.5.sp;
}
