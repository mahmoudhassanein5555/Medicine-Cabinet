import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/theme/app_theme.dart';

import 'core/di/service_locator.dart';
import 'features/household/presentation/view/screens/create_household_screen.dart';
import 'features/household/presentation/view/screens/household_screen.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  runApp(const MyApp());
}

const _testUserId = 'FlwarNVYFWM17QKlEnUm';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          locale: const Locale('ar'),

          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Medicine Cabinet',

          home: Builder(

            builder: (context) => HouseholdScreen(
              userId: _testUserId,
              onCreatePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateHouseholdScreen(
                      userId: _testUserId,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
