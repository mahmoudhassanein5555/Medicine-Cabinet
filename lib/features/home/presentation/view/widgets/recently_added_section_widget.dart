import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/medicine_item_card.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class RecentlyAddedSectionWidget extends StatelessWidget {
  final CabinetSummaryEntity summary;
  final VoidCallback? onSeeAllTap;
  final void Function(MedicineEntity medicine)? onMedicineTap;

  const RecentlyAddedSectionWidget({
    super.key,
    required this.summary,
    this.onSeeAllTap,
    this.onMedicineTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!summary.hasRecentlyAdded) {
      return const SizedBox.shrink();
    }

    final recentList = summary.recentlyAddedMedicines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).homeRecentlyAdded,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            TextButton(
              onPressed: onSeeAllTap,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(40.w, 30.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                S.of(context).commonSeeAll,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ...recentList.take(2).map((medicine) {
          return MedicineItemCard(
            medicine: medicine,
            badgeType: MedicineCardBadgeType.healthy,
            onTap: () => onMedicineTap?.call(medicine),
          );
        }),
      ],
    );
  }
}
