import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract class AppToast {
  static void showToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color color;

    switch (type) {
      case ToastificationType.success:
        color = colorScheme.primary;
        break;

      case ToastificationType.error:
        color = colorScheme.error;
        break;

      case ToastificationType.warning:
        color = colorScheme.secondary;
        break;

      case ToastificationType.info:
        color = colorScheme.primary;
        break;

      default:
        color = colorScheme.primary;
    }

    toastification.show(
      context: context,
      type: type,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      primaryColor: color,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      autoCloseDuration: const Duration(seconds: 3),
      progressBarTheme: ProgressIndicatorThemeData(
        color: color,
      ),
      showProgressBar: true,
    );
  }
}