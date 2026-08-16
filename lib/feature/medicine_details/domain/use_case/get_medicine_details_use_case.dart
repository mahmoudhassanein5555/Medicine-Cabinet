import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/repo/medicine_details_repo_interface.dart';

import '../entity/medicine_entity.dart';

@injectable
class GetMedicineDetailsUseCase {
  final MedicineDetailsRepoInterface repo;

  GetMedicineDetailsUseCase({required this.repo});

  Future<Either<Failure, MedicineDetailsEntity>> invoke({
    required String householdId,
    required String medicineId,
  }) {
    return repo.getMedicineDetails(
      householdId: householdId,
      medicineId: medicineId,
    );
  }
}
