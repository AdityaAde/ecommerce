import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false));
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash-screen.jpg',
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
