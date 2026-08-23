import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/search/data/data_source/search_data_source_interface.dart';
import 'package:medicine_cabinet/features/search/domain/enum/search_medicine_status.dart';
import 'package:medicine_cabinet/features/search/domain/repo/search_repo_interface.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSourceInterface dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<MedicineEntity>>> searchMedicines({
    required String householdId,
    required String query,
  }) async {
    try {
      final result = await dataSource.searchMedicines(
        householdId: householdId,
        query: query,
      );

      return Right(result.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(Failure((context) => S.of(context).failedToLoadMedicines));
    }
  }

  @override
  SearchMedicineStatus getMedicineStatus(MedicineEntity medicine) {
    final now = DateTime.now();

    if (medicine.expiryDate.isBefore(now)) {
      return SearchMedicineStatus.expired;
    }

    final daysUntilExpiry = medicine.expiryDate.difference(now).inDays;

    if (daysUntilExpiry >= 0 && daysUntilExpiry <= 30) {
      return SearchMedicineStatus.expiring;
    }

    if (medicine.quantity <= 5) {
      return SearchMedicineStatus.lowStock;
    }

    return SearchMedicineStatus.healthy;
  }
}
