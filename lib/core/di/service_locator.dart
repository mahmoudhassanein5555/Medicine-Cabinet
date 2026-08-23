import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/features/home/data/data_source/home_data_source.dart';
import 'package:medicine_cabinet/features/home/data/data_source/home_data_source_imp.dart';
import 'package:medicine_cabinet/features/home/data/repository/home_repository_impl.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_medicines_use_case.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_members_use_case.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_user_details_use_case.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_cubit.dart';

import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();

  // Firebase Services
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

  // Home Data Sources
  if (!getIt.isRegistered<HomeRemoteDataSource>()) {
    getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
    );
  }

  // Home Repositories
  if (!getIt.isRegistered<HomeRepository>()) {
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
    );
  }

  // Home Use Cases
  if (!getIt.isRegistered<GetUserDetailsUseCase>()) {
    getIt.registerLazySingleton<GetUserDetailsUseCase>(
      () => GetUserDetailsUseCase(getIt<HomeRepository>()),
    );
  }
  if (!getIt.isRegistered<GetHouseholdMedicinesUseCase>()) {
    getIt.registerLazySingleton<GetHouseholdMedicinesUseCase>(
      () => GetHouseholdMedicinesUseCase(getIt<HomeRepository>()),
    );
  }
  if (!getIt.isRegistered<GetHouseholdMembersUseCase>()) {
    getIt.registerLazySingleton<GetHouseholdMembersUseCase>(
      () => GetHouseholdMembersUseCase(getIt<HomeRepository>()),
    );
  }

  // Home Cubits
  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(
        getUserDetailsUseCase: getIt<GetUserDetailsUseCase>(),
        getHouseholdMedicinesUseCase: getIt<GetHouseholdMedicinesUseCase>(),
        getHouseholdMembersUseCase: getIt<GetHouseholdMembersUseCase>(),
      ),
    );
  }
}
