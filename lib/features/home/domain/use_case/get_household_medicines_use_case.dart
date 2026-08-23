import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class GetHouseholdMedicinesUseCase {
  final HomeRepository _homeRepository;

  GetHouseholdMedicinesUseCase(this._homeRepository);

  Future<Either<Failure, CabinetSummaryEntity>> call(
    String householdId, {
    int lowStockThreshold = 3,
    int expiringSoonDaysThreshold = 30,
  }) async {
    final result = await _homeRepository.getHouseholdMedicines(householdId);

    return result.fold((failure) => Left(failure), (allMedicines) {
      try {
        final now = DateTime.now();

        final activeMedicines = <MedicineEntity>[];
        final rawLowStockMedicines = <MedicineEntity>[];
        final expiringSoonMedicines = <MedicineEntity>[];
        final rawRecentlyAddedMedicines = <MedicineEntity>[];

        for (var medicine in allMedicines) {
          if (medicine.isExpired) continue;

          activeMedicines.add(medicine);

          if (medicine.quantity <= lowStockThreshold) {
            rawLowStockMedicines.add(medicine);
          }

          final differenceInDays = medicine.expiryDate.difference(now).inDays;
          if (differenceInDays >= 0 &&
              differenceInDays <= expiringSoonDaysThreshold) {
            expiringSoonMedicines.add(medicine);
          }

          if (medicine.isRecentlyAdded) {
            rawRecentlyAddedMedicines.add(medicine);
          }
        }

        activeMedicines.sort(
          (a, b) => a.expiryDate.compareTo(b.expiryDate),
        );

        expiringSoonMedicines.sort(
          (a, b) => a.expiryDate.compareTo(b.expiryDate),
        );

        final lowStockMedicines = rawLowStockMedicines;

        rawRecentlyAddedMedicines.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );

        final List<MedicineEntity> recentlyAddedMedicines;
        if (rawRecentlyAddedMedicines.isNotEmpty) {
          recentlyAddedMedicines = rawRecentlyAddedMedicines;
        } else {
          final sortedActive = List<MedicineEntity>.from(activeMedicines)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          recentlyAddedMedicines = sortedActive;
        }

        return Right(
          CabinetSummaryEntity(
            activeMedicines: activeMedicines,
            expiringSoonMedicines: expiringSoonMedicines,
            lowStockMedicines: lowStockMedicines,
            recentlyAddedMedicines: recentlyAddedMedicines,
            totalCount: activeMedicines.length,
            expiringSoonCount: expiringSoonMedicines.length,
            lowStockCount: rawLowStockMedicines.length,
          ),
        );
      } catch (e) {
        return Left(Failure((context) => S.of(context).errorNoInternet));
      }
    });
  }
}
