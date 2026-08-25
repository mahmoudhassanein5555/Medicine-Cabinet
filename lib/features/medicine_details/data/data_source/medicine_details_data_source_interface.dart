import 'package:medicine_cabinet/features/medicine_details/data/dto/medicine_dto.dart';

abstract class MedicineDetailsDataSourceInterface {
  Future<MedicineDetailsDto> getMedicineDetails({
    required String householdId,
    required String medicineId,
  });

  Future<void> updateMedicineQuantity({
    required String householdId,
    required String medicineId,
    required int quantity,
  });

  Future<void> editMedicineDetails({
    required String householdId,
    required String medicineId,
    required String name,
    required String type,
    required String category,
    required DateTime expiryDate,
    required String storageLocation,
  });

  Future<void> deleteMedicine({
    required String householdId,
    required String medicineId,
  });
}
