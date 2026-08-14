import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/household/domain/entity/household_entity.dart';
import 'package:medicine_cabinet/features/household/domain/entity/household_member_entity.dart';
import 'package:medicine_cabinet/features/household/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/household/domain/repo/household_repo_interface.dart';

import '../datasource/household_data_source_interface.dart';

@Injectable(as: HouseholdRepoInterface)
class HouseholdRepoImp implements HouseholdRepoInterface {
  final HouseholdDataSourceInterface _dataSource;
  HouseholdRepoImp(this._dataSource);

  @override
  Future<Either<Failure, HouseholdEntity>> createHousehold({
    required String name,
    required String userId,
  }) async {
    try {
      final dto = await _dataSource.createHousehold(name: name, userId: userId);
      return Right(dto.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, HouseholdEntity?>> getUserHousehold({
    required String userId,
  }) async {
    try {
      final dto = await _dataSource.getUserHousehold(userId: userId);
      if (dto == null) return const Right(null);
      return Right(dto.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, HouseholdEntity>> joinHousehold({
    required String householdId,
    required String userId,
  }) async {
    try {
      final dto = await _dataSource.joinHousehold(
        householdId: householdId,
        userId: userId,
      );
      return Right(dto.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<HouseholdMemberEntity>>> getHouseholdMembers({
    required String householdId,
  }) async {
    try {
      final dtos = await _dataSource.getHouseholdMembers(householdId: householdId);
      return Right(dtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> getMemberMedicines({
    required String householdId,
    required String userId,
  }) async {
    try {
      final dtos = await _dataSource.getMemberMedicines(
        householdId: householdId,
        userId: userId,
      );
      return Right(dtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}