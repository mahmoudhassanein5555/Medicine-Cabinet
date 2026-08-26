import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
import 'package:medicine_cabinet/features/medicine/domain/use_case/filter_medicines_use_case.dart';
import 'package:medicine_cabinet/features/medicine/domain/use_case/get_medicines_use_case.dart';
import 'package:medicine_cabinet/features/medicine/domain/use_case/get_medicine_status_use_case.dart';
import 'medicine_states.dart';

@injectable
class MedicineCubit extends Cubit<MedicineState> {
  final GetMedicinesUseCase getMedicinesUseCase;
  final FilterMedicinesUseCase filterMedicinesUseCase;
  final GetMedicineStatusUseCase getMedicineStatusUseCase;

  MedicineCubit(
    this.getMedicinesUseCase,
    this.filterMedicinesUseCase,
    this.getMedicineStatusUseCase,
  ) : super(MedicineInitialState());

  List<MedicineEntity> allMedicines = [];
  MedicineFilter currentFilter = MedicineFilter.all;
  StreamSubscription? _medicinesSubscription;

  Future<void> getMedicines(String householdId) async {
    emit(MedicineLoadingState());

    final result = await getMedicinesUseCase.invoke(householdId);

    result.fold(
      (failure) {
        emit(MedicineErrorState(failure));
      },
      (medicines) {
        allMedicines = medicines;
        currentFilter = MedicineFilter.all;

        emit(
          MedicineSuccessState(
            medicines: medicines,
            selectedFilter: MedicineFilter.all,
          ),
        );
      },
    );

    _medicinesSubscription?.cancel();
    _medicinesSubscription = FirebaseFirestore.instance
        .collection('households')
        .doc(householdId)
        .collection('medicines')
        .snapshots()
        .skip(1)
        .listen((_) async {
      final res = await getMedicinesUseCase.invoke(householdId);
      res.fold(
        (_) {},
        (medicines) {
          allMedicines = medicines;
          final filteredMedicines = filterMedicinesUseCase.invoke(
            medicines: allMedicines,
            filter: currentFilter,
          );
          emit(
            MedicineSuccessState(
              medicines: filteredMedicines,
              selectedFilter: currentFilter,
            ),
          );
        },
      );
    });
  }

  void filterMedicines(MedicineFilter filter) {
    currentFilter = filter;
    final filteredMedicines = filterMedicinesUseCase.invoke(
      medicines: allMedicines,
      filter: filter,
    );

    emit(
      MedicineSuccessState(
        medicines: filteredMedicines,
        selectedFilter: filter,
      ),
    );
  }

  MedicineStatus getMedicineStatus(MedicineEntity medicine) {
    return getMedicineStatusUseCase.invoke(medicine);
  }

  @override
  Future<void> close() {
    _medicinesSubscription?.cancel();
    return super.close();
  }
}
