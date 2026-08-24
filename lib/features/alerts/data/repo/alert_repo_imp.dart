import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/errors/error_handler.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/alerts/data/datasource/alert_data_source_interface.dart';
import 'package:medicine_cabinet/features/alerts/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/alerts/domain/repo/alert_repo_interface.dart';

@Injectable(as: AlertRepoInterface)
class AlertRepoImp implements AlertRepoInterface {
  final AlertDataSourceInterface _dataSource;
  AlertRepoImp(this._dataSource);
  @override
  Future<Either<Failure, List<MedicineEntity>>> getHouseholdMedicines({
    required String householdId,
  }) async {
    try {
      final dtos = await _dataSource.getHouseholdMedicines(
        householdId: householdId,
      );
      return Right(dtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
