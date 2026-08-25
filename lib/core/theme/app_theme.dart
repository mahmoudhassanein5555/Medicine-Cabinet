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
      tertiary: AppColors.warningLight,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.warningContainerLight,
      onTertiaryContainer: AppColors.warningLight,
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
      // Outlined Button
      // ========================================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: AppColors.borderLight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ========================================================
      // Text Form Field / Input Decoration
      // ========================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,

        hintStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textMutedLight,
          fontSize: 14,
        ),

        prefixIconColor: AppColors.textSecondaryLight,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.borderLight.withValues(alpha: 0.5),
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
        ),

        errorStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.errorLight,
          fontSize: 12,
        ),
      ),

      // ========================================================
      // Typography
      // ========================================================
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),

        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),

        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),

        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),

        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryLight,
          fontFamily: fontFamily,
        ),

        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight,
          fontFamily: fontFamily,
        ),

        bodyMedium: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondaryLight,
          fontFamily: fontFamily,
        ),

        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondaryLight,
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
      tertiary: AppColors.warningDark,
      onTertiary: AppColors.backgroundDark,
      tertiaryContainer: AppColors.surfaceAltDark,
      onTertiaryContainer: AppColors.warningDark,
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
      // Outlined Button
      // ========================================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: AppColors.borderDark, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ========================================================
      // Text Form Field / Input Decoration
      // ========================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAltDark,

        hintStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textMutedDark,
          fontSize: 14,
        ),

        prefixIconColor: AppColors.textSecondaryDark,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.borderDark.withValues(alpha: 0.5),
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 2),
        ),

        errorStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.errorDark,
          fontSize: 12,
        ),
      ),

      // ========================================================
      // Typography
      // ========================================================
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),

        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),

        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),

        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
          fontFamily: fontFamily,
        ),

        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryDark,
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

        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondaryDark,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
