import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/shared_prefs_local_data_source.dart';


@injectable
class LowStockSettingsCubit extends Cubit<int> {
  final CacheHelper _cacheHelper;

  static const String _lowStockKey = 'low_stock_threshold';

  LowStockSettingsCubit(this._cacheHelper)
      : super(
    _cacheHelper.getData(key: _lowStockKey) as int? ?? 5,
  );

  Future<void> changeThreshold(int threshold) async {
    await _cacheHelper.saveData(
      key: _lowStockKey,
      value: threshold,
    );

    emit(threshold);
  }
}