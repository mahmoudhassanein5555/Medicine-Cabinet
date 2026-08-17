import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/stat_card_widget.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class StatCounterCardsWidget extends StatelessWidget {
  final CabinetSummaryEntity summary;
  final VoidCallback? onMedicinesTap;
  final VoidCallback? onExpiringTap;
  final VoidCallback? onLowStockTap;

  const StatCounterCardsWidget({
    super.key,
    required this.summary,
    this.onMedicinesTap,
    this.onExpiringTap,
    this.onLowStockTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: StatCardWidget(
            count: summary.totalCount,
            title: S.of(context).medicinesTitle,
            backgroundColor: isDark
                ? AppColors.primaryLight.withValues(alpha: 0.18)
                : const Color(0xFFE3F1EC),
            onTap: onMedicinesTap,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCardWidget(
            count: summary.expiringSoonCount,
            title: S.of(context).commonExpiringSoon,
            backgroundColor: isDark
                ? AppColors.warningLight.withValues(alpha: 0.18)
                : const Color(0xFFFBEEDC),
            onTap: onExpiringTap,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCardWidget(
            count: summary.lowStockCount,
            title: S.of(context).commonLowStock,
            backgroundColor: isDark
                ? AppColors.errorLight.withValues(alpha: 0.18)
                : const Color(0xFFFAE4E1),
            onTap: onLowStockTap,
          ),
        ),
      ],
    );
  }
}
