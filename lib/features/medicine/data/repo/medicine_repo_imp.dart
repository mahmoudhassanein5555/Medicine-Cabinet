import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine/data/data_source/medicine_data_source_interface.dart';
import 'package:medicine_cabinet/features/medicine/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_filter.dart';
import 'package:medicine_cabinet/features/medicine/domain/enums/medicine_status.dart';
import 'package:medicine_cabinet/features/medicine/domain/repo/medicine_repo_interface.dart';

@LazySingleton(as: MedicineRepoInterface)
class MedicineRepoImpl implements MedicineRepoInterface {
  final MedicineDataSourceInterface dataSource;

  MedicineRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, List<MedicineEntity>>> getMedicines(
    String householdId,
  ) async {
    try {
      final medicines = await dataSource.getMedicines(householdId);

      final entities = medicines
          .map((medicine) => medicine.toEntity())
          .toList();

      return Right(entities);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  List<MedicineEntity> filterMedicines({
    required List<MedicineEntity> medicines,
    required MedicineFilter filter,
  }) {
    final now = DateTime.now();

    switch (filter) {
      case MedicineFilter.all:
        return medicines;

      case MedicineFilter.expiringSoon:
        return medicines.where((medicine) {
          final daysUntilExpiry = medicine.expiryDate.difference(now).inDays;

          return daysUntilExpiry >= 0 && daysUntilExpiry <= 30;
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

  @override
  MedicineStatus getMedicineStatus(MedicineEntity medicine) {
    final now = DateTime.now();

    // Expired
    if (medicine.expiryDate.isBefore(now)) {
      return MedicineStatus.expired;
    }

    // Expiring soon
    final daysUntilExpiry = medicine.expiryDate.difference(now).inDays;

    if (daysUntilExpiry >= 0 && daysUntilExpiry <= 30) {
      return MedicineStatus.expiring;
    }

    // Low stock
    if (medicine.quantity <= 5) {
      return MedicineStatus.lowStock;
    }

    // Healthy
    return MedicineStatus.healthy;
  }
}
