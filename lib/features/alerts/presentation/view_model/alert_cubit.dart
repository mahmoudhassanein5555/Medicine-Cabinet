import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/alerts/domain/use_case/get_household_medicines_use_case.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view_model/alert_state.dart';

import '../../domain/entity/medicine_inventory_category.dart';

class AlertCubit extends Cubit<AlertState> {
  final GetHouseholdMedicinesUseCase _getHouseholdMedicinesUseCase;
  AlertCubit(this._getHouseholdMedicinesUseCase) : super(AlertInitial());
  Future<void> getHouseHoldMedicines({required String householdId}) async {
    emit(AlertLoading());
    final result = await _getHouseholdMedicinesUseCase.invoke(
      householdId: householdId,
    );
    result.fold(
      (failure) {
        emit(AlertError(failure.failuremessage));
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
  }

  void changeCategory(MedicineInventoryCategory category) {
    final currentState = state;

    if (currentState is! AlertSuccess) {
      return;
    }

    final medicines = switch (category) {
      MedicineInventoryCategory.all => currentState.inventory.all,
      MedicineInventoryCategory.recentlyAdded =>
        currentState.inventory.recentlyAdded,
      MedicineInventoryCategory.ended => currentState.inventory.ended,

      MedicineInventoryCategory.expired => currentState.inventory.expired,
    };

    emit(
      currentState.copyWith(selectedCategory: category, medicines: medicines),
    );
  }
}
