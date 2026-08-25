import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/repo/medicine_details_repo_interface.dart';

@injectable
class DeleteMedicineUseCase {
  final MedicineDetailsRepoInterface repo;

  DeleteMedicineUseCase({required this.repo});

  Future<Either<Failure, void>> invoke({
    required String householdId,
    required String medicineId,
  }) {
    return repo.deleteMedicine(
      householdId: householdId,
      medicineId: medicineId,
    );
  }
}
