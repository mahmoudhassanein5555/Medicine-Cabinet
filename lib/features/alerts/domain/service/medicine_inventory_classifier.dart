import 'package:injectable/injectable.dart';

import '../entity/medicine_entity.dart';
import '../entity/medicine_inventory_entity.dart';

@injectable
class MedicineInventoryClassifier {
  MedicineInventoryEntity classify(List<MedicineEntity> medicines) {
    final recentlyAdded = <MedicineEntity>[];
    final valid = <MedicineEntity>[];
    final ended = <MedicineEntity>[];
    final expired = <MedicineEntity>[];

    for (final medicine in medicines) {
      if (medicine.isRecentlyAdded()) {
        recentlyAdded.add(medicine);
      }

      if (medicine.isExpired) {
        expired.add(medicine);
      } else if (medicine.isEnded) {
        ended.add(medicine);
      } else if (medicine.isAvailable) {
        valid.add(medicine);
      }
    }
    return MedicineInventoryEntity(
      recentlyAdded: recentlyAdded,
      valid: valid,
      ended: ended,
      expired: expired,
    );
  }
}
