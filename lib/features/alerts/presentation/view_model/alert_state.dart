
import '../../domain/entity/medicine_entity.dart';
import '../../domain/entity/medicine_inventory_category.dart';
import '../../domain/entity/medicine_inventory_entity.dart';

abstract class AlertState {}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

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
  final String message;
  AlertError(this.message);
}
