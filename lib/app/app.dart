import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/app/themes/theme.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      theme: ThemeData(
        colorScheme: lightColorScheme,
      ),
      home: const LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
