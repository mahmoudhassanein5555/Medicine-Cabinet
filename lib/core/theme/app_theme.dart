import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medicine_cabinet/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // Dynamic Font Helper
  // ============================================================
  static String _getFontFamily(String languageCode) {
    return languageCode == 'ar' ? 'Tajawal' : 'Roboto';
  }

  // ============================================================
  // Light Theme
  // ============================================================
  static ThemeData getLightTheme(String languageCode) {
    final fontFamily = _getFontFamily(languageCode);

    const colorScheme = ColorScheme.light(
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryContainerLight,
      onPrimaryContainer: AppColors.primaryLight,

      secondary: AppColors.secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryContainerLight,
      onSecondaryContainer: AppColors.secondaryLight,

      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      onSurfaceVariant: AppColors.textSecondaryLight,

      outline: AppColors.borderLight,

      error: AppColors.errorLight,
      onError: Colors.white,
      errorContainer: AppColors.errorContainerLight,
      onErrorContainer: AppColors.errorLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // ========================================================
      // App Bar
      // ========================================================
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),

      // ========================================================
      // Elevated Button
      // ========================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ========================================================
      // Typography (مطابق للـ UI والـ Design exact)
      // ========================================================
      textTheme: TextTheme(
        // عناوين اسم المستخدم والعناوين البارزة
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),
        // عناوين الأقسام الرئيسية (ACCOUNT, REMINDERS, APP)
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondaryLight,
          letterSpacing: 1.1,
          fontFamily: fontFamily,
        ),
        // نصوص العناوين في القوائم (Personal information, Privacy...)
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),
        // النصوص الفرعية على اليمين (14 days before, الإيميل)
        bodyMedium: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondaryLight,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  // ============================================================
  // Dark Theme
  // ============================================================
  static ThemeData getDarkTheme(String languageCode) {
    final fontFamily = _getFontFamily(languageCode);

    const colorScheme = ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: AppColors.backgroundDark,

      primaryContainer: AppColors.surfaceAltDark,
      onPrimaryContainer: AppColors.primaryDark,

      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.backgroundDark,

      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      onSurfaceVariant: AppColors.textSecondaryDark,

      outline: AppColors.borderDark,

      error: AppColors.errorDark,
      onError: AppColors.backgroundDark,
      errorContainer: AppColors.surfaceAltDark,
      onErrorContainer: AppColors.errorDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // ========================================================
      // App Bar
      // ========================================================
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // ========================================================
      // Elevated Button
      // ========================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.backgroundDark,
          minimumSize: const Size(double.infinity, 48),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ========================================================
      // Typography
      // ========================================================
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondaryDark,
          letterSpacing: 1.1,
          fontFamily: fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondaryDark,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}