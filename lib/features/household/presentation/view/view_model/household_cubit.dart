import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/household/domain/use_case/get_household_member_use_case.dart';
import 'package:medicine_cabinet/features/household/domain/use_case/get_member_medicines_use_case.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view_model/household_state.dart';

import '../../../domain/use_case/create_household_use_case.dart';
import '../../../domain/use_case/get_user_household_use_case.dart';
import '../../../domain/use_case/join_household_use_case.dart';

@injectable
class HouseholdCubit extends Cubit<HouseholdState> {
  final CreateHouseholdUseCase _createHouseholdUseCase;
  final JoinHouseholdUseCase _joinHouseholdUseCase;
  final GetUserHouseholdUseCase _getUserHouseholdUseCase;
  final GetHouseholdMembersUseCase _getHouseholdMembersUseCase;
  final GetMemberMedicinesUseCase _getMemberMedicinesUseCase;

  HouseholdCubit(
      this._createHouseholdUseCase,
      this._joinHouseholdUseCase,
      this._getUserHouseholdUseCase,
      this._getHouseholdMembersUseCase,
      this._getMemberMedicinesUseCase,
      ) : super(HouseholdInitial());

  Future<void> createHousehold({
    required String name,
    required String userId,
  }) async {
    final householdName = name.trim();

    if (householdName.isEmpty) {
      emit(CreateHouseholdError('Please enter household name'));
      return;
    }
    emit(CreateHouseholdLoading());
    final result = await _createHouseholdUseCase.invoke(
      name: name,
      userId: userId,
    );
    result.fold(
          (failure) => emit(CreateHouseholdError(failure.failuremessage)),
          (household) => emit(CreateHouseholdSuccess(household)),
    );
  }

  Future<void> getUserHousehold({required String userId}) async {
    emit(GetHouseholdLoading());

    final result = await _getUserHouseholdUseCase.invoke(userId: userId);

    result.fold(
          (failure) => emit(GetHouseholdError(failure.failuremessage)),
          (household) => emit(GetHouseholdSuccess(household)),
    );
  }

  Future<void> joinHousehold({
    required String householdId,
    required String userId,
  }) async {
    emit(JoinHouseholdLoading());

    final result = await _joinHouseholdUseCase.invoke(
      householdId: householdId,
      userId: userId,
    );

    result.fold(
          (failure) => emit(JoinHouseholdError(failure.failuremessage)),
          (household) => emit(JoinHouseholdSuccess(household)),
    );
  }

  Future<void> getHouseholdMembers({required String householdId}) async {
    emit(GetMembersLoading());

    final result = await _getHouseholdMembersUseCase.invoke(
      householdId: householdId,
    );

    result.fold(
          (failure) => emit(GetMembersError(failure.failuremessage)),
          (members) => emit(GetMembersSuccess(members)),
    );
  }

  Future<void> getMemberMedicines({
    required String householdId,
    required String userId,
  }) async {
    emit(GetMemberMedicinesLoading());

    final result = await _getMemberMedicinesUseCase.invoke(
      householdId: householdId,
      userId: userId,
    );

    result.fold(
          (failure) => emit(GetMemberMedicinesError(failure.failuremessage)),
          (medicines) => emit(GetMemberMedicinesSuccess(medicines)),
    );
  }
}