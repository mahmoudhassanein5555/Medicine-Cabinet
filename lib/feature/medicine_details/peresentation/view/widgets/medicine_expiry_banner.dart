import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineExpiryBanner extends StatelessWidget {
  final MedicineDetailsEntity medicine;

  const MedicineExpiryBanner({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = S.of(context);

    final today = DateTime.now();

    final expiry = DateTime(
      medicine.expiryDate.year,
      medicine.expiryDate.month,
      medicine.expiryDate.day,
    );

    final currentDay = DateTime(today.year, today.month, today.day);

    final daysLeft = expiry.difference(currentDay).inDays;

    late final Color foreground;
    late final Color background;
    late final IconData icon;
    late final String status;

    if (daysLeft < 0) {
      // Expired
      foreground = colors.error;
      background = colors.error.withValues(alpha: 0.12);
      icon = Icons.error_outline_rounded;
      status = s.commonExpired;
    } else if (daysLeft <= 30) {
      // Expiring soon
      foreground = colors.tertiary;
      background = colors.tertiary.withValues(alpha: 0.12);
      icon = Icons.warning_amber_rounded;
      status = s.commonExpiringSoon;
    } else {
      // Healthy
      foreground = colors.primary;
      background = colors.primary.withValues(alpha: 0.12);
      icon = Icons.check_circle_outline_rounded;
      status = s.commonHealthy;
    }
    final date = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(medicine.expiryDate);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: foreground, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${s.commonExpiryDate}: $date',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
