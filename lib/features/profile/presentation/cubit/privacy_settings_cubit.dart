import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/shared_prefs_local_data_source.dart';
import 'package:injectable/injectable.dart';
@injectable
class PrivacySettingsCubit extends Cubit<bool> {
  final CacheHelper _cacheHelper;

  static const String _showMedicineNameKey =
      'show_medicine_name_in_notifications';

  PrivacySettingsCubit(this._cacheHelper)
      : super(true) {
    _loadSetting();
  }

  void _loadSetting() {
    final savedValue = _cacheHelper.getData(
      key: _showMedicineNameKey,
    );

    if (savedValue is bool) {
      emit(savedValue);
    }
  }

  Future<void> changeShowMedicineName(bool value) async {
    await _cacheHelper.saveData(
      key: _showMedicineNameKey,
      value: value,
    );

    emit(value);
  }
}