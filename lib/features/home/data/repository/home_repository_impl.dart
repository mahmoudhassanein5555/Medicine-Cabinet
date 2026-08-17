import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/data/data_source/home_data_source.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getUserDetails(String userId) async {
    try {
      final user = await _remoteDataSource.getUserDetails(userId);
      return Right(user);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> getHouseholdMedicines(
    String householdId,
  ) async {
    try {
      final medicines = await _remoteDataSource.getHouseholdMedicines(
        householdId,
      );
      return Right(medicines);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MemberEntity>>> getHouseholdMembers(
    String householdId,
  ) async {
    try {
      final members = await _remoteDataSource.getHouseholdMembers(householdId);
      return Right(members);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
