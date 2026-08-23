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

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/datasources/auth_remote_datasource_imp.dart'
    as _i40;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/forgot_password_use_case.dart'
    as _i18;
import '../../features/auth/domain/usecases/google_sign_in_use_case.dart'
    as _i946;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/logout_use_case.dart' as _i711;
import '../../features/auth/domain/usecases/register_use_case.dart' as _i97;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
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
import '../../features/search/data/data_source/search_data_source_imp.dart'
    as _i821;
import '../../features/search/data/data_source/search_data_source_interface.dart'
    as _i384;
import '../../features/search/data/repo/search_repo_imp.dart' as _i773;
import '../../features/search/domain/repo/search_repo_interface.dart' as _i44;
import '../../features/search/domain/use_case/get_search_medicine_status_use_case.dart'
    as _i819;
import '../../features/search/domain/use_case/search_use_case.dart' as _i128;
import '../../features/search/peresentation/view_model/search_cubit.dart'
    as _i585;
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
    gh.lazySingleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appModule.firestore);
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i509.MedicineDataSourceInterface>(
      () => _i796.MedicineDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i384.SearchDataSourceInterface>(
      () => _i821.SearchDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i40.AuthRemoteDatasourceImp(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
    );
    gh.factory<_i44.SearchRepository>(
      () => _i773.SearchRepositoryImpl(gh<_i384.SearchDataSourceInterface>()),
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
    gh.factory<_i819.GetSearchMedicineStatusUseCase>(
      () => _i819.GetSearchMedicineStatusUseCase(gh<_i44.SearchRepository>()),
    );
    gh.factory<_i128.SearchMedicinesUseCase>(
      () => _i128.SearchMedicinesUseCase(gh<_i44.SearchRepository>()),
    );
    gh.factory<_i18.ForgotPasswordUseCase>(
      () => _i18.ForgotPasswordUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i946.GoogleSigninUseCase>(
      () => _i946.GoogleSigninUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i711.LogoutUseCase>(
      () => _i711.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i97.RegisterUseCase>(
      () => _i97.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i776.MedicineCubit>(
      () => _i776.MedicineCubit(
        gh<_i286.GetMedicinesUseCase>(),
        gh<_i789.FilterMedicinesUseCase>(),
        gh<_i1036.GetMedicineStatusUseCase>(),
      ),
    );
    gh.factory<_i585.SearchCubit>(
      () => _i585.SearchCubit(
        gh<_i128.SearchMedicinesUseCase>(),
        gh<_i819.GetSearchMedicineStatusUseCase>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        loginUseCase: gh<_i37.LoginUseCase>(),
        registerUseCase: gh<_i97.RegisterUseCase>(),
        googleSignInUseCase: gh<_i946.GoogleSigninUseCase>(),
        forgotPasswordUseCase: gh<_i18.ForgotPasswordUseCase>(),
        logoutUseCase: gh<_i711.LogoutUseCase>(),
        cacheHelper: gh<_i336.CacheHelper>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
