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
import '../../features/auth/domain/usecases/ForgotPasswordUseCase.dart'
    as _i983;
import '../../features/auth/domain/usecases/GoogleSignInUseCase.dart' as _i339;
import '../../features/auth/domain/usecases/LoginUseCase.dart' as _i934;
import '../../features/auth/domain/usecases/LogoutUseCase.dart' as _i672;
import '../../features/auth/domain/usecases/RegisterUseCase.dart' as _i860;
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
    gh.factory<_i983.ForgotPasswordUseCase>(
      () => _i983.ForgotPasswordUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i339.GoogleSigninUseCase>(
      () => _i339.GoogleSigninUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i934.LoginUseCase>(
      () => _i934.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i672.LogoutUseCase>(
      () => _i672.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i860.RegisterUseCase>(
      () => _i860.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        loginUseCase: gh<_i934.LoginUseCase>(),
        registerUseCase: gh<_i860.RegisterUseCase>(),
        googleSignInUseCase: gh<_i339.GoogleSigninUseCase>(),
        forgotPasswordUseCase: gh<_i983.ForgotPasswordUseCase>(),
        logoutUseCase: gh<_i672.LogoutUseCase>(),
        cacheHelper: gh<_i336.CacheHelper>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
