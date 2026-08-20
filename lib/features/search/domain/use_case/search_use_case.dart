import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/search/domain/repo/search_repo_interface.dart';

@injectable
class SearchMedicinesUseCase {
  final SearchRepository repository;

  SearchMedicinesUseCase(this.repository);

  Future<Either<Failure, List<MedicineEntity>>> invoke({
    required String householdId,
    required String query,
  }) {
    return repository.searchMedicines(householdId: householdId, query: query);
  }
}
