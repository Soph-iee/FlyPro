import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/layout.dart';
import 'package:flypro_expense_tracker/models/users.dart';
import 'package:flypro_expense_tracker/widgets/text_field.dart';
import 'package:flypro_expense_tracker/widgets/primary_btn.dart';
import 'package:flypro_expense_tracker/screens/authentication/register_page.dart';
import 'package:flypro_expense_tracker/screens/authentication/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _handleForgotPassword() => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const ForgotPassword()),
  );

  final repo = AuthRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool _obscurePassword = true;

  void handleLogin() async {
    setState(() => loading = true);
    final user = await repo.login(
      emailController.text,
      passwordController.text,
    );
    setState(() => loading = false);

    if (user != null) {
      if (!mounted) return;
      String userName = user.name;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Layout(userName: userName)),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

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
            Icon(
              Icons.travel_explore,
              color: Theme.of(context).colorScheme.primary,
              size: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            // TEXT
            const Text(
              'Travel Expense Tracker',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
            PrimaryBtn(
              onTap: loading ? null : handleLogin,
              text: 'Login',
            ),
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
