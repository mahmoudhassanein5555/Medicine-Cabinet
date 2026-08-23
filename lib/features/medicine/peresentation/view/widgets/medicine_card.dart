import 'package:flutter/material.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

import 'medicine_status_badge.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.name,
    required this.type,
    required this.remaining,
    required this.expiry,
    required this.addedBy,
    required this.status,
    this.imageUrl,
  });

  final String name;
  final String type;
  final int remaining;
  final String expiry;
  final String addedBy;
  final String status;
  final String? imageUrl;

  bool get isHealthy => status == S.current.commonHealthy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    final Color iconBackground = isHealthy
        ? const Color(0xFFE2F3ED)
        : const Color(0xFFFFEFDC);

    final Color iconColor = isHealthy
        ? const Color(0xFF159374)
        : const Color(0xFFF19A24);

    return Container(
      constraints: const BoxConstraints(minHeight: 116),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Medicine icon
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        imageUrl!,
                        width: 47,
                        height: 47,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Center(child: MedicineIcon(color: iconColor)),
              // child: MedicineIcon(color: iconColor)
            ),
          ),

          const SizedBox(width: 14),

          /// Information
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$type · ${l10n.medicineRemaining(remaining)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '${l10n.medicineExpires(expiry)} · $addedBy',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// Status
          MedicineStatusBadge(status: status),
        ],
      ),
    );
  }
}

class MedicineIcon extends StatelessWidget {
  const MedicineIcon({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 14,
      child: CustomPaint(painter: CapsulePainter(color: color)),
    );
  }
}

class CapsulePainter extends CustomPainter {
  const CapsulePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
      Radius.circular(size.height),
    );

    canvas.drawRRect(rect, paint);

    canvas.drawLine(
      Offset(size.width / 2, 1.5),
      Offset(size.width / 2, size.height - 1.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CapsulePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
