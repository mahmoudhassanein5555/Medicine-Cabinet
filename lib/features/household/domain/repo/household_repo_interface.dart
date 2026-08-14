import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entity/household_entity.dart';
import '../entity/household_member_entity.dart';
import '../entity/medicine_entity.dart';

abstract class HouseholdRepoInterface {
  Future<Either<Failure, HouseholdEntity>> createHousehold({
    required String name,
    required String userId,
  });

  Future<Either<Failure, HouseholdEntity>> joinHousehold({
    required String householdId,
    required String userId,
  });

  Future<Either<Failure, HouseholdEntity?>> getUserHousehold({
    required String userId,
  });

  Future<Either<Failure, List<HouseholdMemberEntity>>> getHouseholdMembers({
    required String householdId,
  });

  Future<Either<Failure, List<MedicineEntity>>> getMemberMedicines({
    required String householdId,
    required String userId,
  });
}