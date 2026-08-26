import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/alerts/domain/use_case/get_household_medicines_use_case.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view_model/alert_state.dart';

import '../../domain/entity/medicine_inventory_category.dart';

@injectable
class AlertCubit extends Cubit<AlertState> {
  final GetHouseholdMedicinesUseCase _getHouseholdMedicinesUseCase;
  StreamSubscription? _subscription;

  AlertCubit(this._getHouseholdMedicinesUseCase) : super(AlertInitial());

  Future<void> getHouseHoldMedicines({required String householdId}) async {
    emit(AlertLoading());
    final result = await _getHouseholdMedicinesUseCase.invoke(
      householdId: householdId,
    );
    result.fold(
      (failure) {
        emit(AlertError(failure));
      },
      (inventory) {
        emit(
          AlertSuccess(
            inventory: inventory,
            selectedCategory: MedicineInventoryCategory.all,
            medicines: inventory.all,
          ),
        );
      },
    );

    _subscription?.cancel();
    _subscription = FirebaseFirestore.instance
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .snapshots()
        .skip(1)
        .listen((_) async {
      final res = await _getHouseholdMedicinesUseCase.invoke(
        householdId: householdId,
      );
      res.fold(
        (_) {},
        (inventory) {
          final currentState = state;
          final category = currentState is AlertSuccess
              ? currentState.selectedCategory
              : MedicineInventoryCategory.all;

          final medicines = switch (category) {
            MedicineInventoryCategory.all => inventory.all,
            MedicineInventoryCategory.valid => inventory.valid,
            MedicineInventoryCategory.recentlyAdded => inventory.recentlyAdded,
            MedicineInventoryCategory.ended => inventory.ended,
            MedicineInventoryCategory.expired => inventory.expired,
          };

          emit(
            AlertSuccess(
              inventory: inventory,
              selectedCategory: category,
              medicines: medicines,
            ),
          );
        },
      );
    });
  }

  void changeCategory(MedicineInventoryCategory category) {
    final currentState = state;

    if (currentState is! AlertSuccess) {
      return;
    }
    emit(AlertLoading(selectedCategory: category));

    final medicines = switch (category) {
      MedicineInventoryCategory.all => currentState.inventory.all,
      MedicineInventoryCategory.valid => currentState.inventory.valid,
      MedicineInventoryCategory.recentlyAdded =>
        currentState.inventory.recentlyAdded,
      MedicineInventoryCategory.ended => currentState.inventory.ended,
      MedicineInventoryCategory.expired => currentState.inventory.expired,
    };

    emit(
      currentState.copyWith(selectedCategory: category, medicines: medicines),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
