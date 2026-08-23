import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/search/domain/enum/search_medicine_status.dart';
import 'package:medicine_cabinet/features/search/domain/use_case/get_search_medicine_status_use_case.dart';
import 'package:medicine_cabinet/features/search/domain/use_case/search_use_case.dart';
import 'package:medicine_cabinet/features/search/peresentation/view_model/search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchStates> {
  final SearchMedicinesUseCase searchMedicinesUseCase;
  final GetSearchMedicineStatusUseCase getSearchMedicineStatusUseCase;

  Timer? _debounce;

  SearchCubit(this.searchMedicinesUseCase, this.getSearchMedicineStatusUseCase)
    : super(SearchInitialState());

  void onSearchChanged({required String householdId, required String query}) {
    _debounce?.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchMedicines(householdId: householdId, query: trimmedQuery);
    });
  }

  Future<void> _searchMedicines({
    required String householdId,
    required String query,
  }) async {
    emit(SearchLoadingState());

    final result = await searchMedicinesUseCase.invoke(
      householdId: householdId,
      query: query,
    );

    result.fold(
      (failure) {
        emit(SearchErrorState(failure));
      },
      (medicines) {
        emit(SearchSuccessState(medicines));
      },
    );
  }

  SearchMedicineStatus getMedicineStatus(MedicineEntity medicine) {
    return getSearchMedicineStatusUseCase.invoke(medicine);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
