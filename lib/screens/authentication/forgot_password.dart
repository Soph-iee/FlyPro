

import 'package:flutter/material.dart';
// import 'package:flypro_expense_tracker/layout.dart';
import 'package:flypro_expense_tracker/models/users.dart';
import 'package:flypro_expense_tracker/widgets/text_field.dart';
import 'package:flypro_expense_tracker/widgets/primary_btn.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final repo = AuthRepository();
  final emailController = TextEditingController();

  bool loading = false;
  bool regsiteredUser = false;

  void handleLogin() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input an email')),
      );
    } else {
      setState(() => loading = true);
      final user = await repo.forgotPassword(
        emailController.text,
      );
      setState(() => loading = false);
      if (user != null) {
        if (!mounted) return;
        regsiteredUser = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A password reset link has been sent to the email'),
          ),
        );

        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This email is not registered')),
        );
      }
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
              hintText: "Input registered email here",
              obscureText: false,
            ),
            const SizedBox(
              height: 12,
            ),

            // ?regsiteredUser
            //     ? MyTextfield(
            //         controller: newPassword,
            //         hintText: "Input new password here",
            //         obscureText: false,
            //       )
            //     : null,
            const SizedBox(
              height: 25,
            ),
            // LOGIN BUTTON
            PrimaryBtn(
              onTap: loading ? null : handleLogin,
              text: regsiteredUser ? 'Proceed to Login' : 'Next',
            ),
            const SizedBox(
              height: 25,
            ),

            // NOT A USER? SIGN IN
          ],
        ),
      ),
    );
  }
}
