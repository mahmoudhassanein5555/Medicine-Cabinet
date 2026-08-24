import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../repo/household_repo_interface.dart';
@injectable
class RemoveMemberUseCase {
  final HouseholdRepoInterface _repo;

  RemoveMemberUseCase(this._repo);

  Future<Either<Failure, void>> invoke({
    required String householdId,
    required String memberId,
    required String currentUserId,
  }) {
    return _repo.removeMember(
      householdId: householdId,
      memberId: memberId,
      currentUserId: currentUserId,
    );
  }
}