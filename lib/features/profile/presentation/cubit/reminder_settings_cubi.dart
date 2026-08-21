import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/shared_prefs_local_data_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReminderSettingsCubit extends Cubit<int> {
  final CacheHelper cacheHelper;

  static const String reminderDaysKey = 'expiry_reminder_days';

  ReminderSettingsCubit(this.cacheHelper)
      : super(
    cacheHelper.getData(key: reminderDaysKey) ?? 14,
  );

  Future<void> changeReminderDays(int days) async {
    await cacheHelper.saveData(
      key: reminderDaysKey,
      value: days,
    );

    emit(days);
  }
}