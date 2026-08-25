import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/widgets/medicine_icon.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.name,
    required this.type,
    required this.remaining,
    required this.expiry,
    required this.addedBy,
    this.imageUrl,
    this.onTap,
  });

  final String name;
  final String type;
  final int remaining;
  final String expiry;
  final String addedBy;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = S.of(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEAF1EE),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.035),
            blurRadius: 12,
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
          splashColor: (isDark ? AppColors.primaryDark : AppColors.primaryLight)
              .withValues(alpha: 0.08),
          highlightColor:
              (isDark ? AppColors.primaryDark : AppColors.primaryLight)
                  .withValues(alpha: 0.04),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Medicine Image / Icon Container
                Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primaryDark.withValues(alpha: 0.12)
                        : AppColors.primaryContainerLight,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.primaryDark.withValues(alpha: 0.2)
                          : AppColors.primaryLight.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: imageUrl != null && imageUrl!.trim().isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl!,
                            width: 52.r,
                            height: 52.r,
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
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.medication_rounded,
                                size: 26.r,
                                color: isDark
                                    ? AppColors.primaryDark
                                    : AppColors.primaryLight,
                              ),
                            ),
                          )
                        : Center(
                            child: MedicineIcon(
                              color: isDark
                                  ? AppColors.primaryDark
                                  : AppColors.primaryLight,
                            ),
                          ),
                  ),
                ),

                SizedBox(width: 14.w),

                /// Medicine Info Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Name + Type Chip
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                                height: 1.25,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          if (type.trim().isNotEmpty) ...[
                            SizedBox(width: 8.w),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceAltDark
                                      : AppColors.surfaceAltLight,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.borderDark
                                        : const Color(0xFFE2EBE7),
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  type,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      SizedBox(height: 6.h),

                      /// Responsive Metadata (Quantity, Expiry, Added By)
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 5.h,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          /// Quantity indicator
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 2.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceAltDark
                                  : const Color(0xFFF3F7F5),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  size: 12.r,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  l10n.medicineRemaining(remaining),
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Expiry Date
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.event_outlined,
                                size: 13.r,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMutedLight,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                expiry,
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),

                          /// Added By
                          if (addedBy.trim().isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  size: 13.r,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textMutedLight,
                                ),
                                SizedBox(width: 3.w),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 110.w),
                                  child: Text(
                                    addedBy,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? AppColors.textMutedDark
                                          : AppColors.textMutedLight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10.w),

                /// Trailing Arrow Indicator
                Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceAltDark
                        : const Color(0xFFF4F7F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12.r,
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textSecondaryLight,
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
