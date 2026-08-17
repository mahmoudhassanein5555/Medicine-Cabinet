import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/alerts/domain/use_case/get_household_medicines_use_case.dart';
import 'package:medicine_cabinet/features/alerts/presentation/view_model/alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  final GetHouseholdMedicinesUseCase _getHouseholdMedicinesUseCase;
  AlertCubit(this._getHouseholdMedicinesUseCase) : super(AlertInitial());
  Future<void> getHouseHoldMedicines({required String householdId}) async {
    emit(AlertLoading());
    final result = await _getHouseholdMedicinesUseCase.invoke(
      householdId: householdId,
    );
    result.fold(
      (failure) => emit(AlertError(failure.failuremessage)),
      (medicines) => emit(AlertSuccess(medicines)),
    );
  }
}
