// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/alerts/data/datasource/alert_data_source_imp.dart'
    as _i305;
import '../../features/alerts/data/datasource/alert_data_source_interface.dart'
    as _i39;
import '../../features/alerts/data/repo/alert_repo_imp.dart' as _i862;
import '../../features/alerts/domain/repo/alert_repo_interface.dart' as _i682;
import '../../features/alerts/domain/service/medicine_inventory_classifier.dart'
    as _i155;
import '../api/api_manager.dart' as _i1047;
import '../network/connection_checker.dart' as _i1050;
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
    gh.factory<_i155.MedicineInventoryClassifier>(
      () => _i155.MedicineInventoryClassifier(),
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i39.AlertDataSourceInterface>(
      () => _i305.AlertDataSourceImp(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i682.AlertRepoInterface>(
      () => _i862.AlertRepoImp(gh<_i39.AlertDataSourceInterface>()),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
