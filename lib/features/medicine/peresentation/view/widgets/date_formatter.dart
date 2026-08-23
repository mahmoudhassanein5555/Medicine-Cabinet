import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatExpiryDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toString();

  return DateFormat('MMM yyyy', locale).format(date);
}
