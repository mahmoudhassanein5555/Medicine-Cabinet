import '../../../domain/entity/household_entity.dart';
import '../../../domain/entity/household_member_entity.dart';
import '../../../domain/entity/medicine_entity.dart';

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

// ==================== Get Members ====================

class GetMembersLoading extends HouseholdState {}

class GetMembersSuccess extends HouseholdState {
  final List<HouseholdMemberEntity> members;

  GetMembersSuccess(this.members);
}

class GetMembersError extends HouseholdState {
  final String message;

  GetMembersError(this.message);
}

// ==================== Get Member Medicines ====================

class GetMemberMedicinesLoading extends HouseholdState {}

class GetMemberMedicinesSuccess extends HouseholdState {
  final List<MedicineEntity> medicines;

  GetMemberMedicinesSuccess(this.medicines);
}

class GetMemberMedicinesError extends HouseholdState {
  final String message;

  GetMemberMedicinesError(this.message);
}
// ==================== Remove Member ====================

class RemoveMemberLoading extends HouseholdState {}

class RemoveMemberSuccess extends HouseholdState {
  final String removedUserId;

  RemoveMemberSuccess(this.removedUserId);
}
class RemoveMemberError extends HouseholdState {
  final String message;

  RemoveMemberError(this.message);
}