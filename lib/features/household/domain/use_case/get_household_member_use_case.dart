import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../entity/household_member_entity.dart';
import '../repo/household_repo_interface.dart';

@injectable
class GetHouseholdMembersUseCase {
  final HouseholdRepoInterface _repo;

  GetHouseholdMembersUseCase(this._repo);

  Future<Either<Failure, List<HouseholdMemberEntity>>> invoke({
    required String householdId,
  }) {
    return _repo.getHouseholdMembers(
      householdId: householdId,
    );
  }
}