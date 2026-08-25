import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entity/medicine_inventory_category.dart';
import 'inventory_category_tab.dart';

class InventoryCategories extends StatelessWidget {
  final MedicineInventoryCategory selectedCategory;
  final ValueChanged<MedicineInventoryCategory> onCategorySelected;

  const InventoryCategories({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: MedicineInventoryCategory.values.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = MedicineInventoryCategory.values[index];
          return InventoryCategoryTab(
            category: category,
            isSelected: selectedCategory == category,
            onTap: () => onCategorySelected(category),
          );
        },
      ),
    );
  }
}