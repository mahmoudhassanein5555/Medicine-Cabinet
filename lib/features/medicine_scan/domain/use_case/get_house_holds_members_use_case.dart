import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/repository/medicine_scan_repository.dart';

@lazySingleton
class GetHouseHoldsMembersUseCase {
  final MedicineScanRepository medicineScanRepository;
  GetHouseHoldsMembersUseCase(this.medicineScanRepository);

  Future<Either<Failure, List<MemberEntity>>> invoke(String houseHoldId) =>
      medicineScanRepository.getHouseholdMembers(houseHoldId);
}
