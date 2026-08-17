import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/alerts/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/alerts/domain/repo/alert_repo_interface.dart';

class GetHouseholdMedicinesUseCase {
  final AlertRepoInterface _repo;
  GetHouseholdMedicinesUseCase(this._repo);
  Future<Either<Failure, List<MedicineEntity>>> invoke({
    required String householdId,
  }) {
    return _repo.getHouseholdMedicines(householdId: householdId);
  }
}
