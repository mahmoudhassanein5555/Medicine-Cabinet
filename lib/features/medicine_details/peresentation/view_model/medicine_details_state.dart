import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';

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
  final String? householdId;
  final Failure? failure;

  const MedicineDetailsState({
    this.status = MedicineDetailsStatus.initial,
    this.medicine,
    this.householdId,
    this.failure,
  });

  MedicineDetailsState copyWith({
    MedicineDetailsStatus? status,
    MedicineDetailsEntity? medicine,
    String? householdId,
    Failure? failure,
  }) {
    return MedicineDetailsState(
      status: status ?? this.status,
      medicine: medicine ?? this.medicine,
      householdId: householdId ?? this.householdId,
      failure: failure,
    );
  }
}
