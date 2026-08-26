import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/household/domain/use_case/get_household_member_use_case.dart';
import 'package:medicine_cabinet/features/household/domain/use_case/get_member_medicines_use_case.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view_model/household_state.dart';
import '../../../domain/use_case/create_household_use_case.dart';
import '../../../domain/use_case/get_user_household_use_case.dart';
import '../../../domain/use_case/join_household_use_case.dart';
import '../../../domain/use_case/remove_member_usecase.dart';

@injectable
class HouseholdCubit extends Cubit<HouseholdState> {
  final CreateHouseholdUseCase _createHouseholdUseCase;
  final JoinHouseholdUseCase _joinHouseholdUseCase;
  final GetUserHouseholdUseCase _getUserHouseholdUseCase;
  final GetHouseholdMembersUseCase _getHouseholdMembersUseCase;
  final GetMemberMedicinesUseCase _getMemberMedicinesUseCase;
  final RemoveMemberUseCase _removeMemberUseCase;

  StreamSubscription? _membersSubscription;
  StreamSubscription? _memberMedicinesSubscription;

  HouseholdCubit(
    this._createHouseholdUseCase,
    this._joinHouseholdUseCase,
    this._getUserHouseholdUseCase,
    this._getHouseholdMembersUseCase,
    this._getMemberMedicinesUseCase,
    this._removeMemberUseCase,
  ) : super(HouseholdInitial());

  Future<void> createHousehold({
    required String name,
    required String userId,
  }) async {
    final householdName = name.trim();

    if (householdName.isEmpty) {
      emit(CreateHouseholdError(Failure.ofString('Please enter household name')));
      return;
    }
    emit(CreateHouseholdLoading());
    final result = await _createHouseholdUseCase.invoke(
      name: name,
      userId: userId,
    );
    result.fold(
      (failure) => emit(CreateHouseholdError(failure)),
      (household) => emit(CreateHouseholdSuccess(household)),
    );
  }

  Future<void> getUserHousehold({required String userId}) async {
    emit(GetHouseholdLoading());

    final result = await _getUserHouseholdUseCase.invoke(userId: userId);

    result.fold(
      (failure) => emit(GetHouseholdError(failure)),
      (household) => emit(GetHouseholdSuccess(household)),
    );
  }

  Future<void> joinHousehold({
    required String householdId,
    required String userId,
  }) async {
    final id = householdId.trim();

    if (id.isEmpty) {
      emit(JoinHouseholdError(Failure.ofString('Please enter household ID')));
      return;
    }

    emit(JoinHouseholdLoading());

    final result = await _joinHouseholdUseCase.invoke(
      householdId: id,
      userId: userId,
    );

    result.fold(
      (failure) => emit(JoinHouseholdError(failure)),
      (household) => emit(JoinHouseholdSuccess(household)),
    );
  }

  Future<void> getHouseholdMembers({
    required String householdId,
    required String currentUserId,
  }) async {
    emit(GetMembersLoading());

    final result = await _getHouseholdMembersUseCase.invoke(
      householdId: householdId,
    );

    result.fold(
      (failure) => emit(GetMembersError(failure)),
      (members) {
        final isCurrentUserAdmin = members.any(
          (member) => member.id == currentUserId && member.role == 'admin',
        );

        emit(GetMembersSuccess(members, isCurrentUserAdmin));
      },
    );

    _membersSubscription?.cancel();
    _membersSubscription = FirebaseFirestore.instance
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .snapshots()
        .skip(1)
        .listen((_) async {
      final res = await _getHouseholdMembersUseCase.invoke(
        householdId: householdId,
      );
      res.fold(
        (_) {},
        (members) {
          final isCurrentUserAdmin = members.any(
            (member) => member.id == currentUserId && member.role == 'admin',
          );
          emit(GetMembersSuccess(members, isCurrentUserAdmin));
        },
      );
    });
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
      (failure) => emit(GetMemberMedicinesError(failure)),
      (medicines) => emit(GetMemberMedicinesSuccess(medicines)),
    );

    _memberMedicinesSubscription?.cancel();
    _memberMedicinesSubscription = FirebaseFirestore.instance
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .snapshots()
        .skip(1)
        .listen((_) async {
      final res = await _getMemberMedicinesUseCase.invoke(
        householdId: householdId,
        userId: userId,
      );
      res.fold(
        (_) {},
        (medicines) => emit(GetMemberMedicinesSuccess(medicines)),
      );
    });
  }

  Future<void> removeMember({
    required String householdId,
    required String memberId,
    required String currentUserId,
  }) async {
    emit(RemoveMemberLoading());

    final result = await _removeMemberUseCase.invoke(
      householdId: householdId,
      memberId: memberId,
      currentUserId: currentUserId,
    );

    result.fold(
      (failure) => emit(RemoveMemberError(failure)),
      (_) => emit(RemoveMemberSuccess(memberId)),
    );
  }

  bool canRemoveMember({
    required String currentUserId,
    required String memberId,
    required bool isCurrentUserAdmin,
  }) {
    return isCurrentUserAdmin && currentUserId != memberId;
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    _memberMedicinesSubscription?.cancel();
    return super.close();
  }
}
