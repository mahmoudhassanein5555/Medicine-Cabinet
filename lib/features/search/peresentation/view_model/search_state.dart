import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<MedicineEntity> medicines;

  SearchSuccessState(this.medicines);
}

class SearchErrorState extends SearchStates {
  final Failure failure;

  SearchErrorState(this.failure);
}
