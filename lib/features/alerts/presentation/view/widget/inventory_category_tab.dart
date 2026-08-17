import 'package:flutter/material.dart';

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

  String get title {
    switch (category) {
      case MedicineInventoryCategory.all:
        return 'All';
      case MedicineInventoryCategory.recentlyAdded:
        return 'Recently Added';
      case MedicineInventoryCategory.ended:
        return 'Ended';

      case MedicineInventoryCategory.expired:
        return 'Expired';
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
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
