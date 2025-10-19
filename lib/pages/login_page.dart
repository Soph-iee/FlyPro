import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/Text_Feild.dart';
import 'package:flypro_expense_tracker/components/primary_btn.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // log user in method
  void logUserIn() async {
    // show loading circle
    // showDialog(
    //   context: context,
    //   builder: (ctx) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
    // final navigator = Navigator.of(context);
    // try login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // wrong username message
      if (e.code == 'user-not-found') {
        errorMessage('user not found');
      }
      // wrong password message
      else if (e.code == 'wrong-password') {
        errorMessage('Please, input the correct password');
      }
    }
    // Navigator.pop(context);
  }

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
