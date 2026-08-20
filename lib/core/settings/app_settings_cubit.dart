import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../utils/shared_prefs_local_data_source.dart';
import 'app_settings_state.dart';

@lazySingleton
class AppSettingsCubit extends Cubit<AppSettingsState> {
  final CacheHelper cacheHelper;

  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language';

  AppSettingsCubit({
    required this.cacheHelper,
  }) : super(const AppSettingsState());

  Future<void> loadSettings() async {
    final isDark = cacheHelper.getData(key: _themeKey) as bool?;
    final language = cacheHelper.getData(key: _languageKey) as String?;

    emit(
      state.copyWith(
        themeMode: isDark == true
            ? ThemeMode.dark
            : ThemeMode.light,
        locale: language == 'ar'
            ? const Locale('ar')
            : const Locale('en'),
      ),
    );
  }

  Future<void> toggleTheme(bool isDark) async {
    await cacheHelper.saveData(
      key: _themeKey,
      value: isDark,
    );

    emit(
      state.copyWith(
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }

  Future<void> changeLanguage(bool isArabic) async {
    final language = isArabic ? 'ar' : 'en';

    await cacheHelper.saveData(
      key: _languageKey,
      value: language,
    );

    emit(
      state.copyWith(
        locale: Locale(language),
      ),
    );
  }
}