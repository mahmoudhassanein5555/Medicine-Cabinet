import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medicine_cabinet/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // Light Theme
  // ============================================================

  static ThemeData get lightTheme {
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

      // Default font
      fontFamily: 'Tajawal',

      colorScheme: colorScheme,

      scaffoldBackgroundColor: AppColors.backgroundLight,

      // ========================================================
      // App Bar
      // ========================================================
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
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
      ////////////////////////////////////
      // Text Form Field / Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        hintStyle: const TextStyle(
          color: AppColors.textMutedLight,
          fontSize: 14,
        ),
        prefixIconColor: AppColors.textSecondaryLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
      ),
      // Typography
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryLight),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondaryLight,
        ),
      ),
    );
  }


      // ========================================================
      // Typography
      // ========================================================
    //   textTheme: const TextTheme(
    //     headlineMedium: TextStyle(
    //       fontSize: 20,
    //       fontWeight: FontWeight.bold,
    //       color: AppColors.textPrimaryLight,
    //     ),
    //     bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryLight),
    //     bodyMedium: TextStyle(
    //       fontSize: 14,
    //       color: AppColors.textSecondaryLight,
    //     ),
    //   ),
  //    );
  // }

  // ============================================================
  // Dark Theme
  // ============================================================

  static ThemeData get darkTheme {
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

      // Default font
      fontFamily: 'Tajawal',

      colorScheme: colorScheme,

      scaffoldBackgroundColor: AppColors.backgroundDark,

      // ========================================================
      // App Bar
      // ========================================================
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
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
      //////////////////////////////////
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: AppColors.borderDark, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAltDark,
        hintStyle: const TextStyle(
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
      ),

      // ========================================================
      // Typography
      // ========================================================
      // textTheme: const TextTheme(
      //   headlineMedium: TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.textPrimaryDark,
      //   ),
      //   bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryDark),
      //   bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondaryDark),
      // ),
      // Typography
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryDark),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondaryDark),
      ),
    );
  }
}
