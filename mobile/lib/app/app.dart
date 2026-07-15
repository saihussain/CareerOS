import 'package:flutter/material.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/auth/screens/login_screen.dart';
import 'theme.dart';

class CareerOSApp extends StatelessWidget {
  const CareerOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareerOS',
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}