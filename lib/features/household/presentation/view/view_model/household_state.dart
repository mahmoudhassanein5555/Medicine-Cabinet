import 'package:medicine_cabinet/core/failure/failure.dart';
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
  final Failure failure;

  CreateHouseholdError(this.failure);
}

// ==================== Join ====================

class JoinHouseholdLoading extends HouseholdState {}

class JoinHouseholdSuccess extends HouseholdState {
  final HouseholdEntity household;

  JoinHouseholdSuccess(this.household);
}

class JoinHouseholdError extends HouseholdState {
  final Failure failure;

  JoinHouseholdError(this.failure);
}

// ==================== Get ====================

class GetHouseholdLoading extends HouseholdState {}

class GetHouseholdSuccess extends HouseholdState {
  final HouseholdEntity? household;

  GetHouseholdSuccess(this.household);
}

class GetHouseholdError extends HouseholdState {
  final Failure failure;

  GetHouseholdError(this.failure);
}

// ==================== Get Members ====================

class GetMembersLoading extends HouseholdState {}

class GetMembersSuccess extends HouseholdState {
  final List<HouseholdMemberEntity> members;
  final bool isCurrentUserAdmin;

  GetMembersSuccess(
    this.members,
    this.isCurrentUserAdmin,
  );
}

class GetMembersError extends HouseholdState {
  final Failure failure;

  GetMembersError(this.failure);
}

// ==================== Get Member Medicines ====================

class GetMemberMedicinesLoading extends HouseholdState {}

class GetMemberMedicinesSuccess extends HouseholdState {
  final List<MedicineEntity> medicines;

  GetMemberMedicinesSuccess(this.medicines);
}

class GetMemberMedicinesError extends HouseholdState {
  final Failure failure;

  GetMemberMedicinesError(this.failure);
}

// ==================== Remove Member ====================

class RemoveMemberLoading extends HouseholdState {}

class RemoveMemberSuccess extends HouseholdState {
  final String removedUserId;

  RemoveMemberSuccess(this.removedUserId);
}

class RemoveMemberError extends HouseholdState {
  final Failure failure;

  RemoveMemberError(this.failure);
}