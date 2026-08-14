import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // ============================================================
  // Light Theme
  // ============================================================

  static const primaryLight = Color(0xFF1F6F5C);
  static const primaryDarkLight = Color(0xFF154F42);
  static const primaryContainerLight = Color(0xFFE3F1EC);

  static const secondaryLight = Color(0xFF3D6FA6);
  static const secondaryContainerLight = Color(0xFFE8EFF6);

  static const backgroundLight = Color(0xFFFAFCFB);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceAltLight = Color(0xFFF2F7F5);

  static const textPrimaryLight = Color(0xFF16211E);
  static const textSecondaryLight = Color(0xFF6C7A76);
  static const textMutedLight = Color(0xFF9AA6A2);

  static const borderLight = Color(0xFFE5ECE9);

  // ============================================================
  // Dark Theme
  // ============================================================

  static const primaryDark = Color(0xFF4FBF9B);
  static const primaryDarkVariant = Color(0xFF3FA989);

  static const secondaryDark = Color(0xFF7AAAD8);

  static const backgroundDark = Color(0xFF0D1513);
  static const surfaceDark = Color(0xFF151F1C);
  static const surfaceAltDark = Color(0xFF1B2622);

  static const textPrimaryDark = Color(0xFFEAF3EF);
  static const textSecondaryDark = Color(0xFF8FA39D);
  static const textMutedDark = Color(0xFF647873);

  static const borderDark = Color(0xFF283733);

  // ============================================================
  // Semantic / State Colors - Light
  // ============================================================

  static const successLight = Color(0xFF2E9469);
  static const successContainerLight = Color(0xFFE4F5EC);

  static const warningLight = Color(0xFFD98A2E);
  static const warningContainerLight = Color(0xFFFBEEDC);

  static const errorLight = Color(0xFFD0483F);
  static const errorContainerLight = Color(0xFFFAE4E1);

  // ============================================================
  // Semantic / State Colors - Dark
  // ============================================================

  static const successDark = Color(0xFF4FBF9B);

  static const warningDark = Color(0xFFE8A353);

  static const errorDark = Color(0xFFE27971);

  // ============================================================
  // Shared / Special
  // ============================================================

  static const householdTertiaryAccent = Color(0xFF8A6FBF);
  static const scannerFrameAccent = Color(0xFF4FBF9B);
}