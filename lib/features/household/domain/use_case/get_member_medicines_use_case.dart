import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/medicine_entity.dart';
import '../repo/household_repo_interface.dart';

@injectable
class GetMemberMedicinesUseCase {
  final HouseholdRepoInterface _repo;

  GetMemberMedicinesUseCase(this._repo);

  Future<Either<Failure, List<MedicineEntity>>> invoke({
    required String householdId,
    required String userId,
  }) {
    return _repo.getMemberMedicines(
      householdId: householdId,
      userId: userId,
    );
  }
}