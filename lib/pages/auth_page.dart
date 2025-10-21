import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/screens/home/home_screen.dart';
// ignore: unused_import
import 'package:flypro_expense_tracker/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // USER LOGGED IN
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          // USER NOT LOGGED IN
          else {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
