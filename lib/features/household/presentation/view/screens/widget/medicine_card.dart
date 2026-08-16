import 'package:flutter/material.dart';

import '../../../../domain/entity/medicine_entity.dart';

/// كارت دواء واحد: صورة + اسم + كمية + تاريخ صلاحية + شارة صالح/منتهي
class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.medicine});

  final MedicineEntity medicine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final expiry = medicine.expiryDate;
    final expiryText =
    expiry != null ? '${_monthName(expiry.month)} ${expiry.year}' : '-';

    final isExpired = medicine.isExpired;
    final hasExpiryInfo = expiry != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpired
              ? Colors.red.withValues(alpha: 0.4)
              : colorScheme.outline,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MedicineImage(imageUrl: medicine.imageUrl, colorScheme: colorScheme),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Text(
                      medicine.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (hasExpiryInfo) _ExpiryBadge(isExpired: isExpired),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Qty: ${medicine.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Expiry: $expiryText',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isExpired ? Colors.red : colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return names[month - 1];
  }
}

class _MedicineImage extends StatelessWidget {
  const _MedicineImage({required this.imageUrl, required this.colorScheme});

  final String? imageUrl;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        color: colorScheme.primary.withValues(alpha: 0.1),
        child: url != null && url.isNotEmpty
            ? Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.medication_outlined, color: colorScheme.primary),
        )
            : Icon(Icons.medication_outlined, color: colorScheme.primary),
      ),
    );
  }
}

class _ExpiryBadge extends StatelessWidget {
  const _ExpiryBadge({required this.isExpired});

  final bool isExpired;

  @override
  Widget build(BuildContext context) {
    final color = isExpired ? Colors.red : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isExpired ? 'Expired' : 'Valid',
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}