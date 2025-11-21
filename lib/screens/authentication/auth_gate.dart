import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flypro_expense_tracker/layout.dart';
import 'package:flypro_expense_tracker/screens/authentication/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Widget> _decideStartPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? sessionJson = prefs.getString('session');
    if (sessionJson == null || sessionJson.isEmpty) {
      return const LoginPage();
    }
    try {
      final Map<String, dynamic> session =
          json.decode(sessionJson) as Map<String, dynamic>;
      final UserModel user = UserModel.fromMap(session);
      if (user.name.isEmpty) return const LoginPage();
      return Layout(user: user);
    } catch (_) {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideStartPage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.data!;
      },
    );
  }
}
