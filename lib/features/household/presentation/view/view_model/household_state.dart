import '../../../domain/entity/household_entity.dart';

abstract class HouseholdState {}

class HouseholdInitial extends HouseholdState {}

// ==================== Create ====================

class CreateHouseholdLoading extends HouseholdState {}

class CreateHouseholdSuccess extends HouseholdState {
  final HouseholdEntity household;

  CreateHouseholdSuccess(this.household);
}

class CreateHouseholdError extends HouseholdState {
  final String message;

  CreateHouseholdError(this.message);
}

// ==================== Join ====================

class JoinHouseholdLoading extends HouseholdState {}

class JoinHouseholdSuccess extends HouseholdState {
  final HouseholdEntity household;

  JoinHouseholdSuccess(this.household);
}

class JoinHouseholdError extends HouseholdState {
  final String message;

  JoinHouseholdError(this.message);
}

// ==================== Get ====================

class GetHouseholdLoading extends HouseholdState {}

class GetHouseholdSuccess extends HouseholdState {
  final HouseholdEntity? household;

  GetHouseholdSuccess(this.household);
}

class GetHouseholdError extends HouseholdState {
  final String message;

  GetHouseholdError(this.message);
}