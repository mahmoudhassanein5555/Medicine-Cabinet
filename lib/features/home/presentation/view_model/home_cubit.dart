import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_medicines_use_case.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_members_use_case.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_user_details_use_case.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetUserDetailsUseCase getUserDetailsUseCase;
  final GetHouseholdMedicinesUseCase getHouseholdMedicinesUseCase;
  final GetHouseholdMembersUseCase getHouseholdMembersUseCase;

  String? _lastUserId;
  String? _lastHouseholdId;
  StreamSubscription? _medicinesSubscription;
  StreamSubscription? _membersSubscription;

  HomeCubit({
    required this.getUserDetailsUseCase,
    required this.getHouseholdMedicinesUseCase,
    required this.getHouseholdMembersUseCase,
  }) : super(const HomeInitial());

  Future<void> loadHomeData({
    required String userId,
    required String householdId,
  }) async {
    _lastUserId = userId;
    _lastHouseholdId = householdId;

    emit(const HomeLoading());

    try {
      final userResult = await getUserDetailsUseCase(userId);
      UserEntity? user;
      Failure? userFailure;

      userResult.fold(
        (failure) => userFailure = failure,
        (data) => user = data,
      );

      if (userFailure != null || user == null) {
        emit(
          HomeError(
            userFailure ??
                Failure((context) => S.of(context).failedToLoadProfile),
          ),
        );
        return;
      }

      final medicinesResult = await getHouseholdMedicinesUseCase(householdId);
      CabinetSummaryEntity? summary;
      Failure? medicinesFailure;

      medicinesResult.fold(
        (failure) => medicinesFailure = failure,
        (data) => summary = data,
      );

      if (medicinesFailure != null || summary == null) {
        emit(
          HomeError(
            medicinesFailure ??
                Failure((context) => S.of(context).failedToLoadMedicines),
          ),
        );
        return;
      }

      final membersResult = await getHouseholdMembersUseCase(
        householdId,
        fallbackUser: user,
        userId: userId,
      );

      List<MemberEntity> members = [];
      membersResult.fold((failure) => members = [], (data) => members = data);

      emit(HomeSuccess(user: user!, summary: summary!, members: members));

      _startRealtimeSubscriptions(userId: userId, householdId: householdId, user: user!);
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(HomeError(failure));
    }
  }

  void _startRealtimeSubscriptions({
    required String userId,
    required String householdId,
    required UserEntity user,
  }) {
    _medicinesSubscription?.cancel();
    _medicinesSubscription = FirebaseFirestore.instance
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .snapshots()
        .skip(1)
        .listen((_) async {
      final medicinesResult = await getHouseholdMedicinesUseCase(householdId);
      medicinesResult.fold(
        (_) {},
        (newSummary) {
          final currentState = state;
          if (currentState is HomeSuccess) {
            emit(currentState.copyWith(summary: newSummary));
          }
        },
      );
    });

    _membersSubscription?.cancel();
    _membersSubscription = FirebaseFirestore.instance
        .collection('households')
        .doc(householdId)
        .collection('members')
        .snapshots()
        .skip(1)
        .listen((_) async {
      final membersResult = await getHouseholdMembersUseCase(
        householdId,
        fallbackUser: user,
        userId: userId,
      );
      membersResult.fold(
        (_) {},
        (newMembers) {
          final currentState = state;
          if (currentState is HomeSuccess) {
            emit(currentState.copyWith(members: newMembers));
          }
        },
      );
    });
  }

  Future<void> refresh() async {
    if (_lastUserId != null && _lastHouseholdId != null) {
      await loadHomeData(userId: _lastUserId!, householdId: _lastHouseholdId!);
    }
  }

  @override
  Future<void> close() {
    _medicinesSubscription?.cancel();
    _membersSubscription?.cancel();
    return super.close();
  }
}
