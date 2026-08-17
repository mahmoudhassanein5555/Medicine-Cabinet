import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/alerts/domain/repo/alert_repo_interface.dart';

import '../service/medicine_inventory_classifier.dart';
import '../entity/medicine_inventory_entity.dart';

class GetHouseholdMedicinesUseCase {
  final AlertRepoInterface _repo;
  final MedicineInventoryClassifier _classifier;
  GetHouseholdMedicinesUseCase(this._repo, this._classifier);

  Future<Either<Failure, MedicineInventoryEntity>> invoke({
    required String householdId,
  }) async {
    final result = await _repo.getHouseholdMedicines(householdId: householdId);

    return result.map((medicines) => _classifier.classify(medicines));
  }
}
