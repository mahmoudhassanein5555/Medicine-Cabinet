import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';

class CabinetSummaryEntity {
  final List<MedicineEntity> activeMedicines;
  final List<MedicineEntity> expiringSoonMedicines;
  final List<MedicineEntity> lowStockMedicines;
  final List<MedicineEntity> recentlyAddedMedicines;
  final int totalCount;
  final int expiringSoonCount;
  final int lowStockCount;

  const CabinetSummaryEntity({
    required this.activeMedicines,
    required this.expiringSoonMedicines,
    required this.lowStockMedicines,
    required this.recentlyAddedMedicines,
    required this.totalCount,
    required this.expiringSoonCount,
    required this.lowStockCount,
  });

  bool get isEmpty => activeMedicines.isEmpty;
  bool get isNotEmpty => activeMedicines.isNotEmpty;
  bool get hasAttentionNeeded =>
      expiringSoonMedicines.isNotEmpty || lowStockMedicines.isNotEmpty;
  bool get hasRecentlyAdded => recentlyAddedMedicines.isNotEmpty;
}
