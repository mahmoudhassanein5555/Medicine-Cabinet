import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/medicine_item_card.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class AttentionNeededSectionWidget extends StatelessWidget {
  final CabinetSummaryEntity summary;
  final VoidCallback? onSeeAllTap;
  final void Function(MedicineEntity medicine)? onMedicineTap;

  const AttentionNeededSectionWidget({
    super.key,
    required this.summary,
    this.onSeeAllTap,
    this.onMedicineTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final expiringList = summary.expiringSoonMedicines;
    final lowStockList = summary.lowStockMedicines;

    if (!summary.hasAttentionNeeded) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).homeAttentionNeeded,
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
                  color: isDark
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ...expiringList.take(2).map((medicine) {
          return MedicineItemCard(
            medicine: medicine,
            badgeType: MedicineCardBadgeType.expiring,
            onTap: () => onMedicineTap?.call(medicine),
          );
        }),
        ...lowStockList.take(2).map((medicine) {
          return MedicineItemCard(
            medicine: medicine,
            badgeType: MedicineCardBadgeType.lowStock,
            onTap: () => onMedicineTap?.call(medicine),
          );
        }),
      ],
    );
  }
}
