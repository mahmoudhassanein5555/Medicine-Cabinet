import 'package:equatable/equatable.dart';
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
  final String errorMessege;
  MedicineScanErrorState(this.errorMessege);

  @override
  List<Object?> get props => [errorMessege];
}

class MedicineScanSuccessState extends MedicineScanStates {
  final MedicineScanEntity? medicineScanEntity;
  MedicineScanSuccessState([this.medicineScanEntity]);

  @override
  List<Object?> get props => [medicineScanEntity];
}

class MedicineScanGetMembersLoadingState extends MedicineScanStates {}

typedef MediceineScanGetMembersLoadingState = MedicineScanGetMembersLoadingState;

class MedicineScanGetMembersErrorState extends MedicineScanStates {
  final String errorMessege;
  MedicineScanGetMembersErrorState(this.errorMessege);

  @override
  List<Object?> get props => [errorMessege];
}

typedef MediceineScanGetMembersErrorState = MedicineScanGetMembersErrorState;

class MedicineScanGetMembersSuccessState extends MedicineScanStates {
  final List<MemberEntity> members;
  MedicineScanGetMembersSuccessState(this.members);

  @override
  List<Object?> get props => [members];
}

typedef MediceineScanGetMembersSuccessState = MedicineScanGetMembersSuccessState;

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
  final String errorMessege;
  AddMedicineErrorState(this.errorMessege);

  @override
  List<Object?> get props => [errorMessege];
}

typedef MedicineScanAddMedicineErrorState = AddMedicineErrorState;

class AddMedicineSuccessState extends MedicineScanStates {}

typedef MedicineScanAddMedicineSuccessState = AddMedicineSuccessState;

