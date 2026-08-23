import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ScreenUtil presentation widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Medicine Cabinet'),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Medicine Cabinet'), findsOneWidget);
  });
}


