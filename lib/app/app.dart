import 'package:final_assignment/screen/splash_screen.dart';
import 'package:final_assignment/theme/theme_data.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(false),
    );
  }
}
