import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/theme/app_theme.dart';

import 'core/di/service_locator.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/views/login_screen.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

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
          // debugShowCheckedModeBanner: false,
          //
          // theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          // themeMode: ThemeMode.system,

          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          // مؤقتًا للتجربة
          themeMode: ThemeMode.dark,
          locale: _locale,

          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: S.delegate.supportedLocales,

          title: 'Medicine Cabinet',

          home: BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      },
    );
  }
}