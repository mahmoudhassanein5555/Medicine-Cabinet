import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';

abstract class MedicineDetailsRepoInterface {
  Future<Either<Failure, MedicineDetailsEntity>> getMedicineDetails({
    required String householdId,
    required String medicineId,
  });

  Future<Either<Failure, void>> updateMedicineQuantity({
    required String householdId,
    required String medicineId,
    required int quantity,
  });

  Future<Either<Failure, void>> editMedicineDetails({
    required String householdId,
    required String medicineId,
    required String name,
    required String type,
    required String category,
    required DateTime expiryDate,
    required String storageLocation,
    required String? description,
  });

  Future<Either<Failure, void>> deleteMedicine({
    required String householdId,
    required String medicineId,
  });
}
