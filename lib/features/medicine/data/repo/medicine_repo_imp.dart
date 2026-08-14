import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/data/data_source/medicine_data_source_interface.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/repo/medicine_repo_interface.dart';

@Injectable(as: MedicineRepoInterface)
class MedicineRepoImpl implements MedicineRepoInterface {
  final MedicineDataSourceInterface dataSource;

  MedicineRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, List<MedicineEntity>>> getMedicines() async {
    try {
      final medicines = await dataSource.getMedicines();

      return Right(medicines.map((medicine) => medicine.toEntity()).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> filterMedicines(
    MedicineFilter filter,
  ) async {
    try {
      final medicines = await dataSource.getMedicines();

      final entities = medicines
          .map((medicine) => medicine.toEntity())
          .toList();

      final filteredMedicines = _filterMedicines(
        medicines: entities,
        filter: filter,
      );

      return Right(filteredMedicines);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  List<MedicineEntity> _filterMedicines({
    required List<MedicineEntity> medicines,
    required MedicineFilter filter,
  }) {
    final now = DateTime.now();

    switch (filter) {
      case MedicineFilter.all:
        return medicines;

      case MedicineFilter.expiringSoon:
        return medicines.where((medicine) {
          final days = medicine.expiryDate.difference(now).inDays;

          return days >= 0 && days <= 30;
        }).toList();

      case MedicineFilter.lowStock:
        return medicines.where((medicine) {
          return medicine.quantity <= 5;
        }).toList();

      case MedicineFilter.expired:
        return medicines.where((medicine) {
          return medicine.expiryDate.isBefore(now);
        }).toList();
    }
  }
}
