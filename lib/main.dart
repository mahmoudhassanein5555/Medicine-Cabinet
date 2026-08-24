import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/bloc_observer/bloc_observer.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/settings/app_settings_cubit.dart';
import 'package:medicine_cabinet/core/settings/app_settings_state.dart';
import 'package:medicine_cabinet/core/theme/app_theme.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/login_screen.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:medicine_cabinet/features/onboarding/onboarding_screen.dart';
import 'package:medicine_cabinet/features/splash_screen.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Dependency Injection
  await configureDependencies();

  // Environment variables
  await dotenv.load(fileName: '.env');

  // Bloc Observer
  Bloc.observer = AppBlocObserver();

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

                  if (currentUser != null) {
                    return 'home';
                  }

                  return 'onboarding';
                },

                onNavigate: (splashContext, route) {
                  if (route == 'home') {
                    Navigator.pushReplacement(
                      splashContext,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<MedicineCubit>(
                          create: (_) => getIt<MedicineCubit>(),
                          child: const CustomBottomNavBar(),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      splashContext,
                      MaterialPageRoute(
                        builder: (_) => OnboardingScreen(
                          onFinished: (onboardingContext) {
                            Navigator.pushReplacement(
                              onboardingContext,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<AuthCubit>(
                                  create: (_) => getIt<AuthCubit>(),
                                  child: const LoginScreen(),
                                ),
                              ),
                            );
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