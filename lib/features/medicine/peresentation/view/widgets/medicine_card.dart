import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_icon.dart';
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
      constraints: BoxConstraints(minHeight: 116.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18.r),
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
            width: 47.r,
            height: 47.r,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: Center(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(13.r),
                      child: Image.network(
                        imageUrl!,
                        width: 47.r,
                        height: 47.r,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Center(child: MedicineIcon(color: iconColor)),
            ),
          ),

          SizedBox(width: 14.w),

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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  '$type · ${l10n.medicineRemaining(remaining)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 3.h),

                Text(
                  '${l10n.medicineExpires(expiry)} · $addedBy',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          /// Status
          MedicineStatusBadge(status: status),
        ],
      ),
    );
  }
}
