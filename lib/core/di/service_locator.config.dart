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
import 'package:firebase_auth/firebase_auth.dart' as _i59;
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
import '../../features/alerts/domain/use_case/get_household_medicines_use_case.dart'
    as _i720;
import '../../features/alerts/presentation/view_model/alert_cubit.dart'
    as _i840;
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
import '../../features/home/data/data_source/home_data_source.dart' as _i68;
import '../../features/home/data/data_source/home_data_source_imp.dart'
    as _i966;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/use_case/get_household_medicines_use_case.dart'
    as _i791;
import '../../features/home/domain/use_case/get_household_members_use_case.dart'
    as _i178;
import '../../features/home/domain/use_case/get_user_details_use_case.dart'
    as _i677;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
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
import '../../features/household/presentation/view/view_model/household_qr_scanner_cubit.dart'
    as _i641;
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
import '../../features/medicine_details/data/data_source/medicine_details_data_source_imp.dart'
    as _i490;
import '../../features/medicine_details/data/data_source/medicine_details_data_source_interface.dart'
    as _i752;
import '../../features/medicine_details/data/repo/medicine_details_repo_imp.dart'
    as _i76;
import '../../features/medicine_details/domain/repo/medicine_details_repo_interface.dart'
    as _i691;
import '../../features/medicine_details/domain/use_case/delete_medicine_use_case.dart'
    as _i24;
import '../../features/medicine_details/domain/use_case/edit_medicine_details_use_case.dart'
    as _i259;
import '../../features/medicine_details/domain/use_case/get_medicine_details_use_case.dart'
    as _i889;
import '../../features/medicine_details/domain/use_case/update_medicine_quantity_use_case.dart'
    as _i59;
import '../../features/medicine_details/peresentation/view_model/medicine_details_cubit.dart'
    as _i323;
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
import '../../features/profile/presentation/view_model/profile_cubit.dart'
    as _i542;
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
import '../settings/app_settings_cubit.dart' as _i798;
import '../utils/household_local_data_source.dart' as _i1006;
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
    gh.lazySingleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appModule.firestore);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i1050.NetworkInfo>(() => _i1050.NetworkInfoImpl());
    gh.factory<_i1006.HouseholdLocalDataSource>(
      () => _i1006.HouseholdLocalDataSource(gh<_i460.SharedPreferences>()),
    );
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
    gh.lazySingleton<_i68.HomeRemoteDataSource>(
      () => _i966.HomeRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i72.GetProfile>(
      () => _i72.GetProfile(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i78.UpdateProfile>(
      () => _i78.UpdateProfile(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i55.HouseholdDataSourceInterface>(
      () => _i838.HouseholdDataSourceImp(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i507.MedicineScanDataSource>(
      () => _i130.MedicineScanDataSourceImp(
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
        dio: gh<_i361.Dio>(),
      ),
    );
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
    gh.factory<_i39.AlertDataSourceInterface>(
      () => _i305.AlertDataSourceImp(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i752.MedicineDetailsDataSourceInterface>(
      () => _i490.MedicineDetailsDataSourceImp(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i541.HomeRepository>(
      () => _i9.HomeRepositoryImpl(gh<_i68.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
    );
    gh.factory<_i44.SearchRepository>(
      () => _i773.SearchRepositoryImpl(gh<_i384.SearchDataSourceInterface>()),
    );
    gh.lazySingleton<_i798.AppSettingsCubit>(
      () => _i798.AppSettingsCubit(cacheHelper: gh<_i336.CacheHelper>()),
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
    gh.lazySingleton<_i785.MedicineRepoInterface>(
      () => _i626.MedicineRepoImpl(gh<_i509.MedicineDataSourceInterface>()),
    );
    gh.lazySingleton<_i510.MedicineScanRepository>(
      () => _i1028.MedicineScanRepositoryImp(
        medicineScanDataSource: gh<_i507.MedicineScanDataSource>(),
      ),
    );
    gh.lazySingleton<_i691.MedicineDetailsRepoInterface>(
      () => _i76.MedicineDetailsRepoImp(
        dataSource: gh<_i752.MedicineDetailsDataSourceInterface>(),
      ),
    );
    gh.factory<_i682.AlertRepoInterface>(
      () => _i862.AlertRepoImp(gh<_i39.AlertDataSourceInterface>()),
    );
    gh.factory<_i542.ProfileCubit>(
      () => _i542.ProfileCubit(
        getProfile: gh<_i72.GetProfile>(),
        updateProfile: gh<_i78.UpdateProfile>(),
      ),
    );
    gh.factory<_i641.HouseholdQrScannerCubit>(
      () => _i641.HouseholdQrScannerCubit(gh<_i973.JoinHouseholdUseCase>()),
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
    gh.factory<_i791.GetHouseholdMedicinesUseCase>(
      () => _i791.GetHouseholdMedicinesUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i178.GetHouseholdMembersUseCase>(
      () => _i178.GetHouseholdMembersUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i677.GetUserDetailsUseCase>(
      () => _i677.GetUserDetailsUseCase(gh<_i541.HomeRepository>()),
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
    gh.lazySingleton<_i902.AnalyzeMedicineImageUseCase>(
      () =>
          _i902.AnalyzeMedicineImageUseCase(gh<_i510.MedicineScanRepository>()),
    );
    gh.lazySingleton<_i306.GetHouseHoldsMembersUseCase>(
      () =>
          _i306.GetHouseHoldsMembersUseCase(gh<_i510.MedicineScanRepository>()),
    );
    gh.factory<_i720.GetHouseholdMedicinesUseCase>(
      () => _i720.GetHouseholdMedicinesUseCase(
        gh<_i682.AlertRepoInterface>(),
        gh<_i155.MedicineInventoryClassifier>(),
      ),
    );
    gh.factory<_i776.MedicineCubit>(
      () => _i776.MedicineCubit(
        gh<_i286.GetMedicinesUseCase>(),
        gh<_i789.FilterMedicinesUseCase>(),
        gh<_i1036.GetMedicineStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i405.AddMedicineUseCase>(
      () => _i405.AddMedicineUseCase(gh<_i510.MedicineScanRepository>()),
    );
    gh.factory<_i585.SearchCubit>(
      () => _i585.SearchCubit(
        gh<_i128.SearchMedicinesUseCase>(),
        gh<_i819.GetSearchMedicineStatusUseCase>(),
      ),
    );
    gh.factory<_i24.DeleteMedicineUseCase>(
      () => _i24.DeleteMedicineUseCase(
        repo: gh<_i691.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i259.EditMedicineDetailsUseCase>(
      () => _i259.EditMedicineDetailsUseCase(
        repo: gh<_i691.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i889.GetMedicineDetailsUseCase>(
      () => _i889.GetMedicineDetailsUseCase(
        repo: gh<_i691.MedicineDetailsRepoInterface>(),
      ),
    );
    gh.factory<_i59.UpdateMedicineQuantityUseCase>(
      () => _i59.UpdateMedicineQuantityUseCase(
        repo: gh<_i691.MedicineDetailsRepoInterface>(),
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
    gh.factory<_i840.AlertCubit>(
      () => _i840.AlertCubit(gh<_i720.GetHouseholdMedicinesUseCase>()),
    );
    gh.factory<_i940.HomeCubit>(
      () => _i940.HomeCubit(
        getUserDetailsUseCase: gh<_i677.GetUserDetailsUseCase>(),
        getHouseholdMedicinesUseCase: gh<_i791.GetHouseholdMedicinesUseCase>(),
        getHouseholdMembersUseCase: gh<_i178.GetHouseholdMembersUseCase>(),
      ),
    );
    gh.factory<_i187.MedicineScanCubit>(
      () => _i187.MedicineScanCubit(
        addMedicineUseCase: gh<_i405.AddMedicineUseCase>(),
        analyzeMedicineImageUseCase: gh<_i902.AnalyzeMedicineImageUseCase>(),
        getHouseHoldsMembersUseCase: gh<_i306.GetHouseHoldsMembersUseCase>(),
      ),
    );
    gh.factory<_i323.MedicineDetailsCubit>(
      () => _i323.MedicineDetailsCubit(
        getMedicineDetailsUseCase: gh<_i889.GetMedicineDetailsUseCase>(),
        updateMedicineQuantityUseCase: gh<_i59.UpdateMedicineQuantityUseCase>(),
        editMedicineDetailsUseCase: gh<_i259.EditMedicineDetailsUseCase>(),
        deleteMedicineUseCase: gh<_i24.DeleteMedicineUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i336.AppModule {}
