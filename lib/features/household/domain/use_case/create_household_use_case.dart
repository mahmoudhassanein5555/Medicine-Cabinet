import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/household_entity.dart';
import '../repo/household_repo_interface.dart';

@injectable
class CreateHouseholdUseCase {
  final HouseholdRepoInterface _repo;

  CreateHouseholdUseCase(this._repo);

  Future<Either<Failure, HouseholdEntity>> invoke({
    required String name,
    required String userId,
  }) {
    return _repo.createHousehold(
      name: name,
      userId: userId,
    );
  }
}