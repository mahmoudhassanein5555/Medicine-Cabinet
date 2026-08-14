import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';

abstract class MedicineRepoInterface {
  Future<Either<Failure, List<MedicineEntity>>> getMedicines();

  List<MedicineEntity> filterMedicines({
    required List<MedicineEntity> medicines,
    required MedicineFilter filter,
  });
  MedicineStatus getMedicineStatus(MedicineEntity medicine);
}
