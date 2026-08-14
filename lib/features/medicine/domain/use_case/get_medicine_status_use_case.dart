import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
import 'package:medicine_cabinet/features/medicine/domain/repo/medicine_repo_interface.dart';

class GetMedicineStatusUseCase {
  final MedicineRepoInterface repository;

  GetMedicineStatusUseCase(this.repository);

  MedicineStatus invoke(MedicineEntity medicine) =>
      repository.getMedicineStatus(medicine);
}
