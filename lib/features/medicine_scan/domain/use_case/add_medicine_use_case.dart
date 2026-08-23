import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/repository/medicine_scan_repository.dart';

@lazySingleton
class AddMedicineUseCase {
  final MedicineScanRepository repository;

  AddMedicineUseCase(this.repository);

  Future<Either<Failure, void>> invoke(
    MedicineEntity medicineEntity,
    String houseId,
  ) => repository.addMedicine(medicineEntity, houseId);
}
