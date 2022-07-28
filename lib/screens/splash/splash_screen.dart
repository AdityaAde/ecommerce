import 'dart:async';
import 'package:ecommerce/blocs/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.authUser != current.authUser,
      listener: (context, state) {
        print('Splash Screen Auth Listener');
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/splash-screen.jpg',
            height: 250,
            width: 250,
          ),
        ),
      ),
    );
  }
}
