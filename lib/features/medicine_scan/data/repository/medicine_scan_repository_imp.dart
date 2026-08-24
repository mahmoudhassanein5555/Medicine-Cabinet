import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/data_source/medicine_scan_data_source.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_scan_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/repository/medicine_scan_repository.dart';

@LazySingleton(as: MedicineScanRepository)
class MedicineScanRepositoryImp implements MedicineScanRepository {
  final MedicineScanDataSource medicineScanDataSource;
  MedicineScanRepositoryImp({required this.medicineScanDataSource});
  @override
  Future<Either<Failure, MedicineScanEntity>> analyzeMidicine(
    File image,
  ) async {
    try {
      final modelResponse = await medicineScanDataSource.analyzeMidicine(image);
      final entityResponse = modelResponse.toEntity();

      return Right(entityResponse);
    } catch (e) {
      debugPrint(
        "Failedddddddddddddddddddddddddddddddddddddddddddddddddd(*Rebo*)",
      );
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMedicine(
    MedicineEntity medicineEntity,
    String houseId,
  ) async {
    try {
      final medicineModel = MedicineModel.fromEntity(medicineEntity);
      await medicineScanDataSource.addMedicine(medicineModel, houseId);
      return Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MemberEntity>>> getHouseholdMembers(
    String houseHoldId,
  ) async {
    try {
      final membrsModel = await medicineScanDataSource.getHouseholdMembers(
        houseHoldId,
      );
      final membrsEntity = membrsModel
          .map((member) => member as MemberEntity)
          .toList();
      return Right(membrsEntity);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
