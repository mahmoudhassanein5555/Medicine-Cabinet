import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/use_case/delete_medicine_use_case.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/use_case/edit_medicine_details_use_case.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/use_case/get_medicine_details_use_case.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/use_case/update_medicine_quantity_use_case.dart';
import 'package:medicine_cabinet/features/medicine_details/peresentation/view_model/medicine_details_state.dart';

@injectable
class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  final GetMedicineDetailsUseCase getMedicineDetailsUseCase;
  final UpdateMedicineQuantityUseCase updateMedicineQuantityUseCase;
  final EditMedicineDetailsUseCase editMedicineDetailsUseCase;
  final DeleteMedicineUseCase deleteMedicineUseCase;

  MedicineDetailsCubit(
    this.getMedicineDetailsUseCase,
    this.updateMedicineQuantityUseCase,
    this.editMedicineDetailsUseCase,
    this.deleteMedicineUseCase,
  ) : super(const MedicineDetailsState());

  Future<void> getMedicineDetails({
    required String householdId,
    required String medicineId,
  }) async {
    emit(
      state.copyWith(
        status: MedicineDetailsStatus.loading,
        householdId: householdId,
        failure: null,
      ),
    );

    try {
      final result = await getMedicineDetailsUseCase.invoke(
        householdId: householdId,
        medicineId: medicineId,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.error,
              failure: failure,
            ),
          );
        },
        (medicine) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.success,
              medicine: medicine,
              failure: null,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MedicineDetailsStatus.error,
          failure: ErrorHandler.handle(e),
        ),
      );
    }
  }

  Future<void> updateQuantity({required int quantity}) async {
    final medicine = state.medicine;
    final householdId = state.householdId;

    if (medicine == null || householdId == null) return;

    emit(
      state.copyWith(
        status: MedicineDetailsStatus.updating,
        failure: null,
      ),
    );

    try {
      final result = await updateMedicineQuantityUseCase.invoke(
        householdId: householdId,
        medicineId: medicine.id,
        quantity: quantity,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.error,
              failure: failure,
            ),
          );
        },
        (_) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.updateSuccess,
              medicine: medicine.copyWith(
                quantity: quantity,
                updatedAt: DateTime.now(),
              ),
              failure: null,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MedicineDetailsStatus.error,
          failure: ErrorHandler.handle(e),
        ),
      );
    }
  }

  Future<void> editDetails({
    required String name,
    required String type,
    required String category,
    required DateTime expiryDate,
    required String storageLocation,
  }) async {
    final medicine = state.medicine;
    final householdId = state.householdId;

    if (medicine == null || householdId == null) return;

    emit(
      state.copyWith(
        status: MedicineDetailsStatus.updating,
        failure: null,
      ),
    );

    try {
      final result = await editMedicineDetailsUseCase.invoke(
        householdId: householdId,
        medicineId: medicine.id,
        name: name,
        type: type,
        category: category,
        expiryDate: expiryDate,
        storageLocation: storageLocation,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.error,
              failure: failure,
            ),
          );
        },
        (_) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.updateSuccess,
              medicine: medicine.copyWith(
                name: name,
                type: type,
                category: category,
                expiryDate: expiryDate,
                storageLocation: storageLocation,
                updatedAt: DateTime.now(),
              ),
              failure: null,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MedicineDetailsStatus.error,
          failure: ErrorHandler.handle(e),
        ),
      );
    }
  }

  Future<void> deleteMedicine() async {
    final medicine = state.medicine;
    final householdId = state.householdId;

    if (medicine == null || householdId == null) return;

    emit(
      state.copyWith(
        status: MedicineDetailsStatus.deleting,
        failure: null,
      ),
    );

    try {
      final result = await deleteMedicineUseCase.invoke(
        householdId: householdId,
        medicineId: medicine.id,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.error,
              failure: failure,
            ),
          );
        },
        (_) {
          emit(
            state.copyWith(
              status: MedicineDetailsStatus.deleteSuccess,
              failure: null,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MedicineDetailsStatus.error,
          failure: ErrorHandler.handle(e),
        ),
      );
    }
  }
}
