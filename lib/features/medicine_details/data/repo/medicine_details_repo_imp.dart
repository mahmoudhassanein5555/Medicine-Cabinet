import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_details/data/data_source/medicine_details_data_source_interface.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_details/domain/repo/medicine_details_repo_interface.dart';

@LazySingleton(as: MedicineDetailsRepoInterface)
class MedicineDetailsRepoImp implements MedicineDetailsRepoInterface {
  final MedicineDetailsDataSourceInterface dataSource;

  MedicineDetailsRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, MedicineDetailsEntity>> getMedicineDetails({
    required String householdId,
    required String medicineId,
  }) async {
    try {
      final dto = await dataSource.getMedicineDetails(
        householdId: householdId,
        medicineId: medicineId,
      );

      return Right(dto.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateMedicineQuantity({
    required String householdId,
    required String medicineId,
    required int quantity,
  }) async {
    try {
      await dataSource.updateMedicineQuantity(
        householdId: householdId,
        medicineId: medicineId,
        quantity: quantity,
      );

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> editMedicineDetails({
    required String householdId,
    required String medicineId,
    required String name,
    required String type,
    required String category,
    required DateTime expiryDate,
    required String storageLocation,
    required String? description,
  }) async {
    try {
      await dataSource.editMedicineDetails(
        householdId: householdId,
        medicineId: medicineId,
        name: name,
        type: type,
        category: category,
        expiryDate: expiryDate,
        storageLocation: storageLocation,
        description: description,
      );

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedicine({
    required String householdId,
    required String medicineId,
  }) async {
    try {
      await dataSource.deleteMedicine(
        householdId: householdId,
        medicineId: medicineId,
      );

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
