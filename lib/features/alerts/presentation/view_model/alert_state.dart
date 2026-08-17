import 'package:medicine_cabinet/features/alerts/domain/entity/medicine_entity.dart';

abstract class AlertState {}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

class AlertSuccess extends AlertState {
  final List<MedicineEntity> medicines;
  AlertSuccess(this.medicines);
}

class AlertError extends AlertState {
  final String message;
  AlertError(this.message);
}
