// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
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
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i40.AuthRemoteDatasourceImp(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
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
