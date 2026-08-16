import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/feature/medicine_details/domain/repo/medicine_details_repo_interface.dart';

@injectable
class GetOwnerNameUseCase {
  final MedicineDetailsRepoInterface repository;

  GetOwnerNameUseCase(this.repository);

  Future<Either<Failure, String?>> invoke(String ownerId) {
    return repository.getOwnerName(ownerId);
  }
}
