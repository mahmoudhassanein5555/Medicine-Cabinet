import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/repo/medicine_repo_interface.dart';

class FilterMedicinesUseCase {
  final MedicineRepoInterface repository;

  FilterMedicinesUseCase(this.repository);

  List<MedicineEntity> invoke({
    required List<MedicineEntity> medicines,
    required MedicineFilter filter,
  }) => repository.filterMedicines(medicines: medicines, filter: filter);
}
