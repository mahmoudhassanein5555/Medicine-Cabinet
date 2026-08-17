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

import '../../features/medicine/data/data_source/medicine_data_source_imp.dart'
    as _i796;
import '../../features/medicine/data/data_source/medicine_data_source_interface.dart'
    as _i509;
import '../../features/medicine/data/repo/medicine_repo_imp.dart' as _i626;
import '../../features/medicine/domain/repo/medicine_repo_interface.dart'
    as _i785;
import '../../features/medicine/domain/use_case/filter_medicines_use_case.dart'
    as _i789;
import '../../features/medicine/domain/use_case/get_medicine_status_use_case.dart'
    as _i1036;
import '../../features/medicine/domain/use_case/get_medicines_use_case.dart'
    as _i286;
import '../../features/medicine/peresentation/view_model/medicine_cubit.dart'
    as _i776;
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
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appModule.firestore);
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i509.MedicineDataSourceInterface>(
      () => _i796.MedicineDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i785.MedicineRepoInterface>(
      () => _i626.MedicineRepoImpl(gh<_i509.MedicineDataSourceInterface>()),
    );
    gh.factory<_i789.FilterMedicinesUseCase>(
      () => _i789.FilterMedicinesUseCase(gh<_i785.MedicineRepoInterface>()),
    );
    gh.factory<_i1036.GetMedicineStatusUseCase>(
      () => _i1036.GetMedicineStatusUseCase(gh<_i785.MedicineRepoInterface>()),
    );
    gh.factory<_i286.GetMedicinesUseCase>(
      () => _i286.GetMedicinesUseCase(gh<_i785.MedicineRepoInterface>()),
    );
    gh.factory<_i776.MedicineCubit>(
      () => _i776.MedicineCubit(
        gh<_i286.GetMedicinesUseCase>(),
        gh<_i789.FilterMedicinesUseCase>(),
        gh<_i1036.GetMedicineStatusUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
