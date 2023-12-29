import 'package:demo/screen/expense/expense_provider.dart';
import 'package:demo/screen/profile/profile_provider.dart';
import 'package:demo/screen/monthly_budget/monthly_provider.dart';
import 'package:demo/screen/auth/splash_screen.dart';
import 'package:demo/screen/sinking_fund/provider_class.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
        MyApp(),
      ],
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => UserProvider()),
          ChangeNotifierProvider(create: (ctx) => MonthlyDataProvider()),
          ChangeNotifierProvider(create: (ctx) => ExpenseProvider()),
          ChangeNotifierProvider(create: (ctx) => FundDataProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
