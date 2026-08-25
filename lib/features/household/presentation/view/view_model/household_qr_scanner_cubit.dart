import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/failure/failure.dart';
import '../../../domain/use_case/join_household_use_case.dart';
import 'household_qr_scanner_state.dart';

@injectable
class HouseholdQrScannerCubit extends Cubit<HouseholdQrScannerState> {
  final JoinHouseholdUseCase _joinHouseholdUseCase;

  HouseholdQrScannerCubit(this._joinHouseholdUseCase)
      : super(HouseholdQrScannerInitial());

  Future<void> scanHousehold({
    required String householdId,
    required String userId,
  }) async {
    final id = householdId.trim();

    if (id.isEmpty) {
      emit(
        HouseholdQrScannerError(
          Failure.ofString('Invalid household QR code'),
        ),
      );
      return;
    }

    emit(HouseholdQrScannerJoining());

    final result = await _joinHouseholdUseCase.invoke(
      householdId: id,
      userId: userId,
    );

    result.fold(
          (failure) => emit(HouseholdQrScannerError(failure)),
          (household) => emit(
        HouseholdQrScannerSuccess(household),
      ),
    );
  }
}