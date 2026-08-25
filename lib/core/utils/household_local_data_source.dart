import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class HouseholdLocalDataSource {
  final SharedPreferences _preferences;
  HouseholdLocalDataSource(this._preferences);

  Future<void> saveHouseholdId(String householdId) async {
    await _preferences.setString(AppKeys.householdId, householdId);
  }

  String? getHouseholdId() {
    return _preferences.getString(AppKeys.householdId);
  }

  Future<void> clearHouseholdId() async {
    await _preferences.remove(AppKeys.householdId);
  }
}
