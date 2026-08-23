import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/theme/app_theme.dart';

import 'features/onboarding/onboarding_screen.dart';
import 'features/splash_screen.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
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
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Medicine Cabinet',
          home: SplashScreen(
            resolveInitialRoute: () async {
              // هنا ممكن تحطي منطق فحص هل دي أول مرة أم لا (مثلاً عبر SharedPreferences)
              // للوقت الحالي هنرجع شاشة الـ Onboarding
              return 'onboarding';
            },
            onNavigate: (context, route) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => OnboardingScreen(
                    onFinished: () {
                      // الانتقال للشاشة الرئيسية بعد إنهاء الـ Onboarding
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
