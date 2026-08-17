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

import '../../features/household/data/datasource/household_data_source_imp.dart'
    as _i838;
import '../../features/household/data/datasource/household_data_source_interface.dart'
    as _i55;
import '../../features/household/data/repo/household_repo_imp.dart' as _i214;
import '../../features/household/domain/repo/household_repo_interface.dart'
    as _i743;
import '../../features/household/domain/use_case/create_household_use_case.dart'
    as _i60;
import '../../features/household/domain/use_case/get_household_member_use_case.dart'
    as _i505;
import '../../features/household/domain/use_case/get_member_medicines_use_case.dart'
    as _i405;
import '../../features/household/domain/use_case/get_user_household_use_case.dart'
    as _i802;
import '../../features/household/domain/use_case/join_household_use_case.dart'
    as _i973;
import '../../features/household/domain/use_case/remove_member_usecase.dart'
    as _i1049;
import '../../features/household/presentation/view/view_model/household_cubit.dart'
    as _i697;
import '../api/api_manager.dart' as _i1047;
import '../network/connection_checker.dart' as _i1050;
import '../utils/household_local_data_source.dart' as _i1006;
import '../utils/shared_prefs_local_data_source.dart' as _i336;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.sharedPrefs,
      preResolve: true,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.factory<_i1006.HouseholdLocalDataSource>(
      () => _i1006.HouseholdLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i55.HouseholdDataSourceInterface>(
      () => _i838.HouseholdDataSourceImp(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i336.CacheHelper>(
      () => _i336.CacheHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i743.HouseholdRepoInterface>(
      () => _i214.HouseholdRepoImp(
        gh<_i55.HouseholdDataSourceInterface>(),
        gh<_i1006.HouseholdLocalDataSource>(),
      ),
    );
    gh.factory<_i60.CreateHouseholdUseCase>(
      () => _i60.CreateHouseholdUseCase(gh<_i743.HouseholdRepoInterface>()),
    );
    gh.factory<_i505.GetHouseholdMembersUseCase>(
      () =>
          _i505.GetHouseholdMembersUseCase(gh<_i743.HouseholdRepoInterface>()),
    );
    gh.factory<_i405.GetMemberMedicinesUseCase>(
      () => _i405.GetMemberMedicinesUseCase(gh<_i743.HouseholdRepoInterface>()),
    );
    gh.factory<_i802.GetUserHouseholdUseCase>(
      () => _i802.GetUserHouseholdUseCase(gh<_i743.HouseholdRepoInterface>()),
    );
    gh.factory<_i973.JoinHouseholdUseCase>(
      () => _i973.JoinHouseholdUseCase(gh<_i743.HouseholdRepoInterface>()),
    );
    gh.factory<_i1049.RemoveMemberUseCase>(
      () => _i1049.RemoveMemberUseCase(gh<_i743.HouseholdRepoInterface>()),
    );
    gh.factory<_i697.HouseholdCubit>(
      () => _i697.HouseholdCubit(
        gh<_i60.CreateHouseholdUseCase>(),
        gh<_i973.JoinHouseholdUseCase>(),
        gh<_i802.GetUserHouseholdUseCase>(),
        gh<_i505.GetHouseholdMembersUseCase>(),
        gh<_i405.GetMemberMedicinesUseCase>(),
        gh<_i1049.RemoveMemberUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}

class _$RegisterModule extends _i291.RegisterModule {}
