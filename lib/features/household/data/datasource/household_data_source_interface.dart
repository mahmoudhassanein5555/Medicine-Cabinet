import '../model/household_member_model.dart';
import '../model/household_model.dart';
import '../model/medicine_model.dart';

abstract class HouseholdDataSourceInterface {
  Future<HouseholdDto> createHousehold({
    required String name,
    required String userId,
  });

  Future<HouseholdDto> joinHousehold({
    required String householdId,
    required String userId,
  });

  Future<HouseholdDto?> getUserHousehold({required String userId});

  Future<List<HouseholdMemberDto>> getHouseholdMembers({
    required String householdId,
  });

  Future<List<MedicineDto>> getMemberMedicines({
    required String householdId,
    required String userId,
  });
  Future<void> removeMember({
    required String householdId,
    required String memberId,
    required String currentUserId,
  });
}
