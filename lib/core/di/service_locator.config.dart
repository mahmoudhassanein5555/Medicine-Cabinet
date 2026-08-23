// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/medicine_scan/data/data_source/medicine_scan_data_source.dart'
    as _i507;
import '../../features/medicine_scan/data/data_source/medicine_scan_data_source_imp.dart'
    as _i130;
import '../../features/medicine_scan/data/repository/medicine_scan_repository_imp.dart'
    as _i1028;
import '../../features/medicine_scan/domain/repository/medicine_scan_repository.dart'
    as _i510;
import '../../features/medicine_scan/domain/use_case/add_medicine_use_case.dart'
    as _i405;
import '../../features/medicine_scan/domain/use_case/analyze_medicine_image_use_case.dart'
    as _i902;
import '../../features/medicine_scan/domain/use_case/get_house_holds_members_use_case.dart'
    as _i306;
import '../../features/medicine_scan/presentation/view_model/medicine_scan_cubit.dart'
    as _i187;
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
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i507.MedicineScanDataSource>(
      () => _i130.MedicineScanDataSourceImp(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
        dio: gh<_i361.Dio>(),
      ),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i510.MedicineScanRepository>(
      () => _i1028.MedicineScanRepositoryImp(
        medicineScanDataSource: gh<_i507.MedicineScanDataSource>(),
      ),
    );
    gh.lazySingleton<_i902.AnalyzeMedicineImageUseCase>(
      () =>
          _i902.AnalyzeMedicineImageUseCase(gh<_i510.MedicineScanRepository>()),
    );
    gh.lazySingleton<_i306.GetHouseHoldsMembersUseCase>(
      () =>
          _i306.GetHouseHoldsMembersUseCase(gh<_i510.MedicineScanRepository>()),
    );
    gh.lazySingleton<_i405.AddMedicineUseCase>(
      () => _i405.AddMedicineUseCase(gh<_i510.MedicineScanRepository>()),
    );
    gh.factory<_i187.MedicineScanCubit>(
      () => _i187.MedicineScanCubit(
        addMedicineUseCase: gh<_i405.AddMedicineUseCase>(),
        analyzeMedicineImageUseCase: gh<_i902.AnalyzeMedicineImageUseCase>(),
        getHouseHoldsMembersUseCase: gh<_i306.GetHouseHoldsMembersUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
