import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/search/domain/enum/search_medicine_status.dart';
import 'package:medicine_cabinet/features/search/domain/repo/search_repo_interface.dart';

@injectable
class GetSearchMedicineStatusUseCase {
  final SearchRepository repository;

  GetSearchMedicineStatusUseCase(this.repository);

  SearchMedicineStatus invoke(MedicineEntity medicine) =>
      repository.getMedicineStatus(medicine);
}
