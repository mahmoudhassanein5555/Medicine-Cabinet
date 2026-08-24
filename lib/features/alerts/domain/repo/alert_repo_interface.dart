import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/alerts/domain/entity/medicine_entity.dart';

abstract class AlertRepoInterface {
  Future<Either<Failure, List<MedicineEntity>>> getHouseholdMedicines({
    required String householdId,
  });
}
