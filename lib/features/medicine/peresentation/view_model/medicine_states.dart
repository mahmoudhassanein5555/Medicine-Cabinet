import '../../domain/entity/medicine_entity.dart';

abstract class MedicineState {}

class MedicineInitialState extends MedicineState {}

class MedicineLoadingState extends MedicineState {}

class MedicineSuccessState extends MedicineState {
  final List<MedicineEntity> medicines;

  MedicineSuccessState(this.medicines);
}

class MedicineFailureState extends MedicineState {
  final String message;

  MedicineFailureState(this.message);
}
