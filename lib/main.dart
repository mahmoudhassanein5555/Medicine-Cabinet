import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:medicine_cabinet/core/bloc_observer/bloc_observer.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/theme/app_theme.dart';

import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/login_screen.dart';

import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';

import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';

import 'package:medicine_cabinet/features/onboarding/onboarding_screen.dart';
import 'package:medicine_cabinet/features/splash_screen.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Medicine Cabinet',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          locale: _locale,

          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: S.delegate.supportedLocales,

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
                            builder: (_) => BlocProvider(
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
  }
}

// home: const SearchScreen(householdId: 'household123');
