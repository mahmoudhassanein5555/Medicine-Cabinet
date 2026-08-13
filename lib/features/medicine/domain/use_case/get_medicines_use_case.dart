import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/repo/medicine_repo_interface.dart';

class GetMedicinesUseCase {
  final MedicineRepoInterface repository;

  GetMedicinesUseCase(this.repository);

  Future<Either<Failure, List<MedicineEntity>>> invoke() =>
      repository.getMedicines();
}
