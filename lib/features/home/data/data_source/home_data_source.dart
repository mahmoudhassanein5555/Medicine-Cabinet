import 'package:medicine_cabinet/features/home/data/models/medicine_dto.dart';
import 'package:medicine_cabinet/features/home/data/models/member_dto.dart';
import 'package:medicine_cabinet/features/home/data/models/user_dto.dart';

abstract class HomeRemoteDataSource {
  Future<UserDto> getUserDetails(String userId);

  Future<List<MedicineDto>> getHouseholdMedicines(String householdId);

  Future<List<MemberDto>> getHouseholdMembers(String householdId);
}
