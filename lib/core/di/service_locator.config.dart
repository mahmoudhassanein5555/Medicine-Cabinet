// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/profile/data/datasource/profile_remote_data_source.dart'
    as _i559;
import '../../features/profile/data/datasource/profile_remote_data_source_imp.dart'
    as _i9;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_profile.dart' as _i72;
import '../../features/profile/domain/usecases/update_profile.dart' as _i78;
import '../../features/profile/presentation/cubit/low_stock_settings_cubit.dart'
    as _i600;
import '../../features/profile/presentation/cubit/privacy_settings_cubit.dart'
    as _i138;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i36;
import '../../features/profile/presentation/cubit/reminder_settings_cubi.dart'
    as _i48;
import '../api/api_manager.dart' as _i1047;
import '../network/connection_checker.dart' as _i1050;
import '../settings/app_settings_cubit.dart' as _i798;
import '../utils/shared_prefs_local_data_source.dart' as _i336;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.sharedPrefs,
      preResolve: true,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appModule.firestore);
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i559.ProfileRemoteDataSource>(
      () => _i9.ProfileRemoteDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(
        remoteDataSource: gh<_i559.ProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i72.GetProfile>(
      () => _i72.GetProfile(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i78.UpdateProfile>(
      () => _i78.UpdateProfile(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i600.LowStockSettingsCubit>(
      () => _i600.LowStockSettingsCubit(gh<_i336.CacheHelper>()),
    );
    gh.factory<_i138.PrivacySettingsCubit>(
      () => _i138.PrivacySettingsCubit(gh<_i336.CacheHelper>()),
    );
    gh.lazySingleton<_i798.AppSettingsCubit>(
      () => _i798.AppSettingsCubit(cacheHelper: gh<_i336.CacheHelper>()),
    );
    gh.factory<_i48.ReminderSettingsCubit>(
      () => _i48.ReminderSettingsCubit(gh<_i336.CacheHelper>()),
    );
    gh.factory<_i36.ProfileCubit>(
      () => _i36.ProfileCubit(
        getProfile: gh<_i72.GetProfile>(),
        updateProfile: gh<_i78.UpdateProfile>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
