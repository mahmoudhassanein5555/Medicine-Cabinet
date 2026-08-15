import 'package:medicine_cabinet/feature/medicine_details/domain/entity/medicine_entity.dart';

enum MedicineDetailsStatus {
  initial,
  loading,
  success,
  error,

  updating,
  updateSuccess,

  deleting,
  deleteSuccess,
}

class MedicineDetailsState {
  final MedicineDetailsStatus status;
  final MedicineDetailsEntity? medicine;
  final String? errorMessage;

  const MedicineDetailsState({
    this.status = MedicineDetailsStatus.initial,
    this.medicine,
    this.errorMessage,
  });

  MedicineDetailsState copyWith({
    MedicineDetailsStatus? status,
    MedicineDetailsEntity? medicine,
    String? errorMessage,
  }) {
    return MedicineDetailsState(
      status: status ?? this.status,
      medicine: medicine ?? this.medicine,
      errorMessage: errorMessage,
    );
  }
}
