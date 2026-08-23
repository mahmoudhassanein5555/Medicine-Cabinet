import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/repo/medicine_details_repo_interface.dart';

@injectable
class EditMedicineDetailsUseCase {
  final MedicineDetailsRepoInterface repository;

  EditMedicineDetailsUseCase({required this.repository});

  Future<Either<Failure, void>> invoke({
    required String householdId,
    required String medicineId,
    required String name,
    required String type,
    required String category,
    required DateTime expiryDate,
    required String storageLocation,
    required String? description,
  }) {
    return repository.editMedicineDetails(
      householdId: householdId,
      medicineId: medicineId,
      name: name,
      type: type,
      category: category,
      expiryDate: expiryDate,
      storageLocation: storageLocation,
      description: description,
    );
  }
}
