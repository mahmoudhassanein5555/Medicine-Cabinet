
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/household_entity.dart';
import '../repo/household_repo_interface.dart';

@injectable
class JoinHouseholdUseCase {
  final HouseholdRepoInterface _repo;

  JoinHouseholdUseCase(this._repo);

  Future<Either<Failure, HouseholdEntity>> invoke({
    required String householdId,
    required String userId,
  }) {
    return _repo.joinHousehold(
      householdId: householdId,
      userId: userId,
    );
  }
}