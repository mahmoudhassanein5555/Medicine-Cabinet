
import 'package:medicine_cabinet/core/failure/failure.dart';
import '../../domain/entity/medicine_entity.dart';
import '../../domain/entity/medicine_inventory_category.dart';
import '../../domain/entity/medicine_inventory_entity.dart';

abstract class AlertState {}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {
  final MedicineInventoryEntity? inventory;
  final MedicineInventoryCategory selectedCategory;

  AlertLoading({
    this.inventory,
    this.selectedCategory = MedicineInventoryCategory.all,
  });
}

class AlertSuccess extends AlertState {
  final MedicineInventoryEntity inventory;
  final MedicineInventoryCategory selectedCategory;
  final List<MedicineEntity> medicines;

  AlertSuccess({
    required this.inventory,
    required this.selectedCategory,
    required this.medicines,
  });

  AlertSuccess copyWith({
    MedicineInventoryEntity? inventory,
    MedicineInventoryCategory? selectedCategory,
    List<MedicineEntity>? medicines,
  }) {
    return AlertSuccess(
      inventory: inventory ?? this.inventory,
      selectedCategory:
      selectedCategory ?? this.selectedCategory,
      medicines: medicines ?? this.medicines,
    );
  }
}

class AlertError extends AlertState {
  final Failure failure;
  AlertError(this.failure);
}
