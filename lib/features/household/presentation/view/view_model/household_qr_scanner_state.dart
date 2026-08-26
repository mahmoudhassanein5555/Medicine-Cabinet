import 'package:medicine_cabinet/core/failure/failure.dart';
import '../../../domain/entity/household_entity.dart';

abstract class HouseholdQrScannerState {}

class HouseholdQrScannerInitial extends HouseholdQrScannerState {}

class HouseholdQrScannerJoining extends HouseholdQrScannerState {}

class HouseholdQrScannerSuccess extends HouseholdQrScannerState {
  final HouseholdEntity household;

  HouseholdQrScannerSuccess(this.household);
}

class HouseholdQrScannerError extends HouseholdQrScannerState {
  final Failure failure;

  HouseholdQrScannerError(this.failure);
}