import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/Text_Feild.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
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
            SizedBox(
              height: 100,
            ),
            Icon(
              Icons.travel_explore,
              size: 100,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Travel Expense Tracker',
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            SizedBox(
              height: 25,
            ),
            MyTextfield(
              controller: usernameController,
              hintText: "username",
              obscureText: false,
            ),
            SizedBox(
              height: 25,
            ),
            MyTextfield(
              controller: passwordController,
              hintText: "password",
              obscureText: true,
            ),
            SizedBox(
              height: 25,
            ),
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
          ],
        ),
      ),
    );
  }
}
