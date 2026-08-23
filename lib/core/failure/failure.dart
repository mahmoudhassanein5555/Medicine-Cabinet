import 'package:flutter/material.dart';

class Failure {
  final String Function(BuildContext context) getMessage;

  Failure(this.getMessage);

  factory Failure.ofString(String message) {
    return Failure((_) => message);
  }
}