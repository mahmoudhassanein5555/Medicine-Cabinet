import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_scan_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';

abstract class MedicineScanRepository {
  Future<Either<Failure, MedicineScanEntity>> analyzeMidicine(File image);
  Future<Either<Failure, Unit>> addMedicine(
    MedicineEntity medicineEntity,
    String houseId,
  );
  Future<Either<Failure, List<MemberEntity>>> getHouseholdMembers(
    String houseHoldId,
  );
}
