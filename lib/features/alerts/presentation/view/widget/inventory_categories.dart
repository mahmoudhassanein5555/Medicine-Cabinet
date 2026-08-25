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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < MedicineInventoryCategory.values.length; i++) ...[
            if (i > 0) SizedBox(width: 8.w),

            InventoryCategoryTab(
              category: MedicineInventoryCategory.values[i],
              isSelected:
                  selectedCategory == MedicineInventoryCategory.values[i],
              onTap: () {
                onCategorySelected(
                  MedicineInventoryCategory.values[i],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}