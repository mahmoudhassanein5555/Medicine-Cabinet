import 'package:flutter/material.dart';

import '../../../domain/entity/medicine_inventory_category.dart';
import 'inventory_category_tab.dart';

class InventoryCategories extends StatelessWidget {
  final MedicineInventoryCategory selectedCategory;
  final ValueChanged<MedicineInventoryCategory>
  onCategorySelected;

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
          for (final category
          in MedicineInventoryCategory.values)
            InventoryCategoryTab(
              category: category,
              isSelected:
              selectedCategory == category,
              onTap: () {
                onCategorySelected(category);
              },
            ),
        ],
      ),
    );
  }
}