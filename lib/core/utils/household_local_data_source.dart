import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class HouseholdLocalDataSource {
  final SharedPreferences _preferences;
  HouseholdLocalDataSource(this._preferences);
  static const _householdIdKey = 'cached_household_id';
  Future<void> saveHouseholdId(String householdId) async {
    await _preferences.setString(_householdIdKey, householdId);
  }

  String? getHouseholdId() {
    return _preferences.getString(_householdIdKey);
  }

  Future<void> clearHouseholdId() async {
    await _preferences.remove(_householdIdKey);
  }
}
