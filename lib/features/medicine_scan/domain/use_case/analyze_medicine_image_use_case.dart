import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_scan_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/repository/scan_medicine_repository.dart';

class AnalyzeMedicineImageUseCase {
  final MedicineScanRepository medicineScanRepository;
  AnalyzeMedicineImageUseCase(this.medicineScanRepository);

  Future<Either<Failure, MedicineScanEntity>> invoke(File image) =>
      medicineScanRepository.analyzeMidicine(image);
}
