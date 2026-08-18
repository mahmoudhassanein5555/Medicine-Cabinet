import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? AppColors.primaryDarkLight
              : AppColors.textPrimaryDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          title(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? AppColors.textPrimaryDark
                : AppColors.primaryDarkLight,
          ),
        ),
      ),
    );
  }
}
