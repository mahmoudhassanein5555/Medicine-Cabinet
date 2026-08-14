import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/service_locator.dart';
import 'features/auth/presentation/views/login_screen.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("1️⃣ Flutter Binding initialized");

  try {
    print("2️⃣ Starting dependencies configuration...");
    await configureDependencies();
    print("3️⃣ Dependencies configured successfully!");
  } catch (e) {
    print("❌ Error in configureDependencies: $e");
  }

  try {
    print("4️⃣ Initializing Firebase...");
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("5️⃣ Firebase initialized successfully!");
  } catch (e) {
    print("❌ Error in Firebase.initializeApp: $e");
  }

  print("6️⃣ Running App...");
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
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Flutter Demo',
          home:LoginScreen(),


          // const Scaffold(
          //   body: Center(
          //     child: Text('Hello World'),
          //   ),
          // )
        );
      },
    );
  }
}

