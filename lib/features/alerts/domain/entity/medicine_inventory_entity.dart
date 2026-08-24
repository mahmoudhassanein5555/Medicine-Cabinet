import 'medicine_entity.dart';

class MedicineInventoryEntity {
  final List<MedicineEntity> recentlyAdded;
  final List<MedicineEntity> valid;
  final List<MedicineEntity> ended;
  final List<MedicineEntity> expired;

  MedicineInventoryEntity({
    required this.recentlyAdded,
    required this.valid,
    required this.ended,
    required this.expired,
  });

  List<MedicineEntity> get all {
    final recentlyAddedIds = recentlyAdded.map((medicine) => medicine.id).toSet();

    return [
      ...recentlyAdded,
      ...valid.where(
            (medicine) => !recentlyAddedIds.contains(medicine.id),
      ),
      ...ended,
      ...expired,
    ];
  }
}