import 'medicine_entity.dart';

class MedicineInventoryEntity {
  final List<MedicineEntity> recentlyAdded;
  final List<MedicineEntity> available;
  final List<MedicineEntity> ended;
  final List<MedicineEntity> expired;

  MedicineInventoryEntity({
    required this.recentlyAdded,
    required this.available,
    required this.ended,
    required this.expired,
  });

  List<MedicineEntity> get all {
    return [
      ...recentlyAdded,
      ...available,
      ...ended,
      ...expired,
    ];
  }
}