import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, UserEntity>> getUserDetails(String userId);

  Future<Either<Failure, List<MedicineEntity>>> getHouseholdMedicines(
    String householdId,
  );

  Future<Either<Failure, List<MemberEntity>>> getHouseholdMembers(
    String householdId,
  );
}
