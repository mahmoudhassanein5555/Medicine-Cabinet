import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';

class FilterMedicinesUseCase {
  List<MedicineEntity> invoke({
    required List<MedicineEntity> medicines,
    required MedicineFilter filter,
  }) {
    final now = DateTime.now();

    switch (filter) {
      case MedicineFilter.all:
        return medicines;

      case MedicineFilter.expiringSoon:
        return medicines.where((medicine) {
          final difference = medicine.expiryDate.difference(now).inDays;

          return difference >= 0 && difference <= 30;
        }).toList();

      case MedicineFilter.lowStock:
        return medicines.where((medicine) {
          return medicine.quantity <= 5;
        }).toList();

      case MedicineFilter.expired:
        return medicines.where((medicine) {
          return medicine.expiryDate.isBefore(now);
        }).toList();
    }
  }
}
