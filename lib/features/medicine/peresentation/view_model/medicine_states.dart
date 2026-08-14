import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';

import '../../domain/entity/medicine_entity.dart';

abstract class MedicineState {}

class MedicineInitialState extends MedicineState {}

class MedicineLoadingState extends MedicineState {}

class MedicineSuccessState extends MedicineState {
  final List<MedicineEntity> medicines;
  final MedicineFilter selectedFilter;

  MedicineSuccessState({required this.medicines, required this.selectedFilter});
}

class MedicineErrorState extends MedicineState {
  final String message;

  MedicineErrorState(this.message);
}
