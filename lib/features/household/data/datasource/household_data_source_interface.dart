import '../model/household_model.dart';

abstract class HouseholdDataSourceInterface {
  Future<HouseholdDto> createHousehold({
    required String name,
    required String userId,
  });

  Future<HouseholdDto> joinHousehold({
    required String householdId,
    required String userId,
  });

  Future<HouseholdDto?> getUserHousehold({
    required String userId,
  });
}