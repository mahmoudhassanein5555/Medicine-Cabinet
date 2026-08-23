import 'package:flutter/material.dart';

class Failure {
  final String Function(BuildContext context) getMessage;

  Failure(this.getMessage);

  // لاستقبال النصوص المباشرة التي لا تحتاج ترجمة
  factory Failure.ofString(String message) {
    return Failure((_) => message);
  }
}