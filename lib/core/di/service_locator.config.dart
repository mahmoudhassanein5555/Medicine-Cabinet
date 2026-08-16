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

import '../../feature/medicine_details/data/data_source/medicine_details_data_source_imp.dart'
    as _i1009;
import '../../feature/medicine_details/data/data_source/medicine_details_data_source_interface.dart'
    as _i480;
import '../../feature/medicine_details/data/repo/medicine_details_repo_imp.dart'
    as _i264;
import '../../feature/medicine_details/domain/repo/medicine_details_repo_interface.dart'
    as _i63;
import '../../feature/medicine_details/domain/use_case/delete_medicine_use_case.dart'
    as _i853;
import '../../feature/medicine_details/domain/use_case/edit_medicine_details_use_case.dart'
    as _i199;
import '../../feature/medicine_details/domain/use_case/get_medicine_details_use_case.dart'
    as _i543;
import '../../feature/medicine_details/domain/use_case/get_owner_name_use_case.dart'
    as _i703;
import '../../feature/medicine_details/domain/use_case/update_medicine_quantity_use_case.dart'
    as _i1025;
import '../../feature/medicine_details/peresentation/view_model/medicine_details_cubit.dart'
    as _i327;
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
    gh.lazySingleton<_i480.MedicineDetailsDataSourceInterface>(
      () => _i1009.MedicineDetailsDataSourceImp(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i63.MedicineDetailsRepoInterface>(
      () => _i264.MedicineDetailsRepoImp(
        dataSource: gh<_i480.MedicineDetailsDataSourceInterface>(),
      ),
    );
    gh.factory<_i703.GetOwnerNameUseCase>(
      () => _i703.GetOwnerNameUseCase(gh<_i63.MedicineDetailsRepoInterface>()),
    );
    gh.factory<_i853.DeleteMedicineUseCase>(
      () => _i853.DeleteMedicineUseCase(
        repo: gh<_i63.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i543.GetMedicineDetailsUseCase>(
      () => _i543.GetMedicineDetailsUseCase(
        repo: gh<_i63.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i1025.UpdateMedicineQuantityUseCase>(
      () => _i1025.UpdateMedicineQuantityUseCase(
        repo: gh<_i63.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i199.EditMedicineDetailsUseCase>(
      () => _i199.EditMedicineDetailsUseCase(
        repository: gh<_i63.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i327.MedicineDetailsCubit>(
      () => _i327.MedicineDetailsCubit(
        gh<_i543.GetMedicineDetailsUseCase>(),
        gh<_i1025.UpdateMedicineQuantityUseCase>(),
        gh<_i199.EditMedicineDetailsUseCase>(),
        gh<_i853.DeleteMedicineUseCase>(),
        gh<_i703.GetOwnerNameUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
