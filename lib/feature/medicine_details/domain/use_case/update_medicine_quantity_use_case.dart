import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/repo/medicine_details_repo_interface.dart';

@injectable
class UpdateMedicineQuantityUseCase {
  final MedicineDetailsRepoInterface repo;

  UpdateMedicineQuantityUseCase({required this.repo});

  Future<Either<Failure, void>> invoke({
    required String householdId,
    required String medicineId,
    required int quantity,
  }) {
    return repo.updateMedicineQuantity(
      householdId: householdId,
      medicineId: medicineId,
      quantity: quantity,
    );
  }
}
