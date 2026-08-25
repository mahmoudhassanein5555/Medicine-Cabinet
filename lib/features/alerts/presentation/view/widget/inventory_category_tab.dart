import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

import '../../../../../generated/l10n.dart';
import '../../../domain/entity/medicine_inventory_category.dart';

class InventoryCategoryTab extends StatelessWidget {
  final MedicineInventoryCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const InventoryCategoryTab({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  String title(BuildContext context) {
    final l10n = S.of(context);

    switch (category) {
      case MedicineInventoryCategory.all:
        return l10n.medicineCategoryAll;

      case MedicineInventoryCategory.valid:
        return l10n.medicineCategoryValid;

      case MedicineInventoryCategory.recentlyAdded:
        return l10n.medicineCategoryRecentlyAdded;

      case MedicineInventoryCategory.ended:
        return l10n.medicineCategoryEnded;

      case MedicineInventoryCategory.expired:
        return l10n.medicineCategoryExpired;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isSelected
              ? (isDark ? AppColors.primaryDark : AppColors.primaryLight)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceAltLight),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.primaryDark : AppColors.primaryLight)
                : (isDark ? AppColors.borderDark : const Color(0xFFE2EBE7)),
            width: 1,
          ),
        ),
        child: Text(
          title(context),
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? (isDark ? AppColors.backgroundDark : Colors.white)
                : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
          ),
        ),
      ),
    );
  }
}
