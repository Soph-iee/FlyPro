import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flypro_expense_tracker/layout.dart';
import 'package:flypro_expense_tracker/widgets/text_field.dart';
import 'package:flypro_expense_tracker/widgets/primary_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flypro_expense_tracker/pages/register_page.dart';
import 'package:flypro_expense_tracker/pages/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, String>> _allowedUsers = [];
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadAllowedUsers();
  }

  Future<void> _loadAllowedUsers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? stored = prefs.getString('users');
      if (stored == null || stored.isEmpty) {
        final String jsonString = await rootBundle.loadString(
          'assets/data/users.json',
        );
        stored = jsonString;
        await prefs.setString('users', stored);
      }
      final List<dynamic> data = json.decode(stored) as List<dynamic>;
      setState(() {
        _allowedUsers = data
            .whereType<Map<String, dynamic>>()
            .map(
              (e) => <String, String>{
                'email': (e['email'] ?? '').toString().trim().toLowerCase(),
                'password': (e['password'] ?? '').toString(),
                'name': (e['name'] ?? '').toString(),
              },
            )
            .toList();
      });
    } catch (e) {
      errorMessage('Failed to load users.json');
    }
  }

  void logUserIn() {
    final String inputEmail = emailController.text.trim().toLowerCase();
    final String inputPassword = passwordController.text;

    final Map<String, String> matchedUser = _allowedUsers.firstWhere(
      (user) =>
          user['email'] == inputEmail && user['password'] == inputPassword,
      orElse: () => <String, String>{},
    );

    if (matchedUser.isNotEmpty) {
      final String userName = matchedUser['name']!;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Layout(userName: userName)),
      );
    } else {
      errorMessage('Invalid credentials');
    }
  }

  Future<void> _handleForgotPassword() =>
      ForgotPasswordFlow.handleForgotPassword(context);

  void errorMessage(String data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(data),
        );
      },
    );
  }

  // text editing contollers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),

            // Flypro LOGO
            const Icon(
              Icons.travel_explore,
              size: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            // TEXT
            Text(
              'Travel Expense Tracker',
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            // USERNAME INPUT FIELD
            MyTextfield(
              controller: emailController,
              hintText: "username",
              obscureText: false,
            ),
            const SizedBox(
              height: 25,
            ),
            // PASSWORD INPUT FIELD
            MyTextfield(
              controller: passwordController,
              hintText: "password",
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // FORGOT PASSWORD SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _handleForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // LOGIN BUTTON
            PrimaryBtn(onTap: logUserIn),
            const SizedBox(
              height: 25,
            ),
            // NOT A USER? SIGN IN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a User?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    ' Sign In',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
