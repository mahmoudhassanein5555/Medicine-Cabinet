import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/service_locator.dart';
import 'core/settings/app_settings_cubit.dart';
import 'core/settings/app_settings_state.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();

  runApp(
    BlocProvider(
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

              theme: AppTheme.getLightTheme(languageCode),
              darkTheme: AppTheme.getDarkTheme(languageCode),
              themeMode: state.themeMode,

              locale: state.locale,

              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              supportedLocales: S.delegate.supportedLocales,

              title: 'Medicine Cabinet',

              home: const ProfileScreen(),
            );
          },
        );
      },
    );
  }
}