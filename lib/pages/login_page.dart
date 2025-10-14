import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/Text_Feild.dart';
import 'package:flypro_expense_tracker/components/primary_btn.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // log user in method
  void logUserIn() {
    
  }

  // text editing contollers
  final usernameController = TextEditingController();
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
              controller: usernameController,
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
              obscureText: true,
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
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a User?'),

                Text(
                  ' Sign In',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
