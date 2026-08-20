import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/repository/scan_medicine_repository.dart';

class AddMedicineUseCase {
  final MedicineScanRepository repository;

  AddMedicineUseCase(this.repository);

  Future<Either<Failure, void>> invoke(MedicineEntity medicineEntity) async =>
      await repository.addMedicine(medicineEntity);
}
