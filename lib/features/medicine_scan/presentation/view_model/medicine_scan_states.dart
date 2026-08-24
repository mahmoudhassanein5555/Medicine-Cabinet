import 'package:equatable/equatable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_scan_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';

abstract class MedicineScanStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class MedicineScanInitialState extends MedicineScanStates {}

typedef MedicineScanIntialState = MedicineScanInitialState;

class MedicineScanLoadingState extends MedicineScanStates {}

class MedicineScanErrorState extends MedicineScanStates {
  final Failure failure;
  MedicineScanErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class MedicineScanSuccessState extends MedicineScanStates {
  final MedicineScanEntity? medicineScanEntity;
  MedicineScanSuccessState([this.medicineScanEntity]);

  @override
  List<Object?> get props => [medicineScanEntity];
}

class MedicineScanGetMembersLoadingState extends MedicineScanStates {}

typedef MediceineScanGetMembersLoadingState =
    MedicineScanGetMembersLoadingState;

class MedicineScanGetMembersErrorState extends MedicineScanStates {
  final Failure failure;
  MedicineScanGetMembersErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}

typedef MediceineScanGetMembersErrorState = MedicineScanGetMembersErrorState;

class MedicineScanGetMembersSuccessState extends MedicineScanStates {
  final List<MemberEntity> members;
  MedicineScanGetMembersSuccessState(this.members);

  @override
  List<Object?> get props => [members];
}

typedef MediceineScanGetMembersSuccessState =
    MedicineScanGetMembersSuccessState;

class MedicineScanFormDataUpdatedState extends MedicineScanStates {
  final int quantity;
  final String selectedMember;
  final DateTime? selectedExpiryDate;
  final int timestamp;

  MedicineScanFormDataUpdatedState({
    required this.quantity,
    required this.selectedMember,
    this.selectedExpiryDate,
    int? timestamp,
  }) : timestamp = timestamp ?? DateTime.now().microsecondsSinceEpoch;

  @override
  List<Object?> get props => [
    quantity,
    selectedMember,
    selectedExpiryDate,
    timestamp,
  ];
}

class AddMedicineLoadingState extends MedicineScanStates {}

typedef MedicineScanAddMedicineLoadingState = AddMedicineLoadingState;

class AddMedicineErrorState extends MedicineScanStates {
  final Failure failure;
  AddMedicineErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}

typedef MedicineScanAddMedicineErrorState = AddMedicineErrorState;

class AddMedicineSuccessState extends MedicineScanStates {}

typedef MedicineScanAddMedicineSuccessState = AddMedicineSuccessState;
