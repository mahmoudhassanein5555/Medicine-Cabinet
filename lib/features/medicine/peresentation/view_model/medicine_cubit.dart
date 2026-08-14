import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
import 'package:medicine_cabinet/features/medicine/domain/use_case/filter_medicines_use_case.dart';
import 'package:medicine_cabinet/features/medicine/domain/use_case/get_medicines_use_case.dart';
import 'package:medicine_cabinet/features/medicine/domain/use_case/get_medicine_status_use_case.dart';
import 'medicine_states.dart';

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

  Future<void> getMedicines() async {
    emit(MedicineLoadingState());

    final result = await getMedicinesUseCase.invoke();

    result.fold(
      (failure) {
        emit(MedicineErrorState(failure.failuremessage));
      },
      (medicines) {
        allMedicines = medicines;

        emit(
          MedicineSuccessState(
            medicines: medicines,
            selectedFilter: MedicineFilter.all,
          ),
        );
      },
    );
  }

  void filterMedicines(MedicineFilter filter) {
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
}
