import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MedicineRepoInterface {
  Future<Either<Failure, List<MedicineEntity>>> getMedicines();
}
