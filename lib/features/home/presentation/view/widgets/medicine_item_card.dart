import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

enum MedicineCardBadgeType { expiring, lowStock, healthy }

class MedicineItemCard extends StatelessWidget {
  final MedicineEntity medicine;
  final MedicineCardBadgeType badgeType;
  final VoidCallback? onTap;

  const MedicineItemCard({
    super.key,
    required this.medicine,
    this.badgeType = MedicineCardBadgeType.healthy,
    this.onTap,
  });

  String _formatExpiryDifference(BuildContext context, DateTime expiry) {
    final now = DateTime.now();
    final difference = expiry.difference(now).inDays;

    if (difference <= 0) {
      return S.of(context).commonExpired;
    } else if (difference == 1) {
      return S.of(context).homeExpiresTomorrow;
    } else if (difference < 30) {
      return S.of(context).homeExpiresInDays(difference);
    } else {
      final months = (difference / 30).floor();
      return months == 1
          ? S.of(context).homeExpiresInMonth
          : S.of(context).homeExpiresInMonths(months);
    }
  }

  String _formatDateAdded(BuildContext context, DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt).inDays;

    if (difference == 0) {
      return S.of(context).homeAddedToday;
    } else if (difference == 1) {
      return S.of(context).homeAddedYesterday;
    } else {
      return S.of(context).homeAddedDaysAgo(difference);
    }
  }

  String _getRemainingQuantityText(BuildContext context) {
    final type = medicine.type.toLowerCase();
    final quantity = medicine.quantity;
    if (type.contains('tablet') || type.contains('pill')) {
      return S.of(context).homeTabletsRemaining(quantity);
    } else if (type.contains('capsule')) {
      return S.of(context).homeCapsulesRemaining(quantity);
    } else if (type.contains('syrup') ||
        type.contains('liquid') ||
        type.contains('bottle')) {
      return S.of(context).homeBottlesRemaining(quantity);
    } else if (type.contains('spray') || type.contains('inhaler')) {
      return S.of(context).homeUnitsRemaining(quantity);
    }
    return S.of(context).homeRemaining(quantity);
  }

  String _getLocalizedType(BuildContext context, String type) {
    final lower = type.toLowerCase();
    if (lower.contains('tablet') || lower.contains('pill')) {
      return S.of(context).scanUnitTablets;
    } else if (lower.contains('capsule')) {
      return S.of(context).commonCapsules;
    } else if (lower.contains('syrup') ||
        lower.contains('liquid') ||
        lower.contains('bottle')) {
      return S.of(context).commonBottles;
    } else if (lower.contains('spray') || lower.contains('inhaler')) {
      return S.of(context).commonUnits;
    }
    return type.isNotEmpty ? type : S.of(context).commonUnits;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color iconBgColor;
    final Color badgeBgColor;
    final Color badgeTextColor;
    final String badgeText;

    switch (badgeType) {
      case MedicineCardBadgeType.expiring:
        iconBgColor = isDark
            ? AppColors.warningLight.withValues(alpha: 0.15)
            : const Color(0xFFFBEEDC);
        badgeBgColor = isDark
            ? AppColors.warningLight.withValues(alpha: 0.2)
            : const Color(0xFFFBEEDC);
        badgeTextColor = const Color(0xFFD98A2E);
        badgeText = S.of(context).commonExpiringShort;
        break;

      case MedicineCardBadgeType.lowStock:
        iconBgColor = isDark
            ? AppColors.warningLight.withValues(alpha: 0.15)
            : const Color(0xFFFBEEDC);
        badgeBgColor = isDark
            ? AppColors.warningLight.withValues(alpha: 0.2)
            : const Color(0xFFFBEEDC);
        badgeTextColor = const Color(0xFFD98A2E);
        badgeText = S.of(context).commonLow;
        break;

      case MedicineCardBadgeType.healthy:
        iconBgColor = isDark
            ? AppColors.successLight.withValues(alpha: 0.15)
            : const Color(0xFFE4F5EC);
        badgeBgColor = isDark
            ? AppColors.successLight.withValues(alpha: 0.2)
            : const Color(0xFFE4F5EC);
        badgeTextColor = const Color(0xFF2E9469);
        badgeText = S.of(context).commonHealthy;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEEF3F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: CachedNetworkImage(
                      imageUrl: medicine.imageUrl,
                      width: 48.r,
                      height: 48.r,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: isDark
                                ? AppColors.primaryDark
                                : AppColors.primaryLight,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.medication_rounded,
                        color: isDark
                            ? Colors.white70
                            : AppColors.textSecondaryLight,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      if (badgeType == MedicineCardBadgeType.expiring) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 13.sp,
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textMutedLight,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                _formatExpiryDifference(
                                  context,
                                  medicine.expiryDate,
                                ),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _getRemainingQuantityText(context),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ] else if (badgeType ==
                          MedicineCardBadgeType.lowStock) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 13.sp,
                              color: const Color(0xFFD98A2E),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              S.of(context).commonLowStock,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _getRemainingQuantityText(context),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ] else ...[
                        Text(
                          '${medicine.quantity} ${_getLocalizedType(context, medicine.type)} · ${_formatDateAdded(context, medicine.createdAt)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: badgeTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
