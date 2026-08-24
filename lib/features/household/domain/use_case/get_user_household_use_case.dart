import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/household_entity.dart';
import '../repo/household_repo_interface.dart';

@injectable
class GetUserHouseholdUseCase {
  final HouseholdRepoInterface _repo;

  GetUserHouseholdUseCase(this._repo);

  Future<Either<Failure, HouseholdEntity?>> invoke({
    required String userId,
  }) {
    return _repo.getUserHousehold(
      userId: userId,
    );
  }
}