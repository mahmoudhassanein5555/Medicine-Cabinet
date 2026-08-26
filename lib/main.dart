import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/settings/app_settings_cubit.dart';
import 'package:medicine_cabinet/core/settings/app_settings_state.dart';
import 'package:medicine_cabinet/core/theme/app_theme.dart';
import 'package:medicine_cabinet/core/utils/household_local_data_source.dart';
import 'package:medicine_cabinet/core/utils/shared_prefs_local_data_source.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/login_screen.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/household_screen.dart';
import 'package:medicine_cabinet/features/onboarding/onboarding_screen.dart';
import 'package:medicine_cabinet/features/splash_screen.dart';
import 'package:medicine_cabinet/firebase_options.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  runApp(
    BlocProvider<AppSettingsCubit>(
      create: (_) => getIt<AppSettingsCubit>()..loadSettings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<AppSettingsCubit, AppSettingsState>(
          builder: (context, state) {
            final String languageCode = state.locale.languageCode;

            return MaterialApp(
              debugShowCheckedModeBanner: false,

              title: 'Medicine Cabinet',

              // Theme
              theme: AppTheme.getLightTheme(languageCode),
              darkTheme: AppTheme.getDarkTheme(languageCode),
              themeMode: state.themeMode,

              // Localization
              locale: state.locale,

              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              supportedLocales: S.delegate.supportedLocales,

              // Initial Screen
              home: SplashScreen(
                resolveInitialRoute: () async {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  final cacheHelper = getIt<CacheHelper>();

                  if (currentUser != null) {
                    final localDataSource = getIt<HouseholdLocalDataSource>();

                    final cachedUserId = cacheHelper.getData(
                      key: AppKeys.userId,
                    );
                    if (cachedUserId == null) {
                      await cacheHelper.saveData(
                        key: AppKeys.userId,
                        value: currentUser.uid,
                      );
                    }

                    final householdId = localDataSource.getHouseholdId();
                    if (householdId != null && householdId.isNotEmpty) {
                      return 'home';
                    }
                    return 'household';
                  }

                  final hasSeenOnboarding = cacheHelper.getData(
                    key: AppKeys.hasSeenOnboarding,
                  );

                  if (hasSeenOnboarding == true) {
                    return 'login';
                  }

                  return 'onboarding';
                },

                onNavigate: (splashContext, route) {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  final householdId = getIt<HouseholdLocalDataSource>()
                      .getHouseholdId();

                  if (route == 'home' && currentUser != null) {
                    Navigator.pushReplacement(
                      splashContext,
                      MaterialPageRoute(
                        builder: (_) => CustomBottomNavBar(
                          userId: currentUser.uid,
                          householdId: householdId,
                        ),
                      ),
                    );
                  } else if (route == 'household' && currentUser != null) {
                    Navigator.pushReplacement(
                      splashContext,
                      MaterialPageRoute(
                        builder: (_) =>
                            HouseholdScreen(userId: currentUser.uid),
                      ),
                    );
                  } else if (route == 'login') {
                    Navigator.pushReplacement(
                      splashContext,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<AuthCubit>(
                          create: (_) => getIt<AuthCubit>(),
                          child: const LoginScreen(),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      splashContext,
                      MaterialPageRoute(
                        builder: (_) => OnboardingScreen(
                          onFinished: (onboardingContext) async {
                            await getIt<CacheHelper>().saveData(
                              key: AppKeys.hasSeenOnboarding,
                              value: true,
                            );
                            if (onboardingContext.mounted) {
                              Navigator.pushReplacement(
                                onboardingContext,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider<AuthCubit>(
                                    create: (_) => getIt<AuthCubit>(),
                                    child: const LoginScreen(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
