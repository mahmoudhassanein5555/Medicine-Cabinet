import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_cabinet/features/home/data/data_source/home_data_source.dart';
import 'package:medicine_cabinet/features/home/data/data_source/home_data_source_imp.dart';
import 'package:medicine_cabinet/features/home/data/repository/home_repository_impl.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_medicines_use_case.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_members_use_case.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_user_details_use_case.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Firebase Services
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  }

  // Data Sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetUserDetailsUseCase>(
    () => GetUserDetailsUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetHouseholdMedicinesUseCase>(
    () => GetHouseholdMedicinesUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetHouseholdMembersUseCase>(
    () => GetHouseholdMembersUseCase(getIt<HomeRepository>()),
  );

  // Cubits / ViewModels
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getUserDetailsUseCase: getIt<GetUserDetailsUseCase>(),
      getHouseholdMedicinesUseCase: getIt<GetHouseholdMedicinesUseCase>(),
      getHouseholdMembersUseCase: getIt<GetHouseholdMembersUseCase>(),
    ),
  );
}