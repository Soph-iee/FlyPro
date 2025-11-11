import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flypro_expense_tracker/screens/pages/auth_gate.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset(
          'assets/data/splashscreen.json',
        ),
      ),
      splashIconSize: 500,
      nextScreen: const AuthGate(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: 5000,
    );
  }
}
