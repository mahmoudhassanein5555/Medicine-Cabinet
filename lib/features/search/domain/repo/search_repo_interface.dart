import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/search/domain/enum/search_medicine_status.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<MedicineEntity>>> searchMedicines({
    required String householdId,
    required String query,
  });
  SearchMedicineStatus getMedicineStatus(MedicineEntity medicine);
}
