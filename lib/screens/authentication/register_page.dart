import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flypro_expense_tracker/widgets/text_field.dart';
import 'package:flypro_expense_tracker/widgets/primary_btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _saveUser() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim().toLowerCase();
    final String password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(24),
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text(
            'Please all fields',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? stored = prefs.getString('users');
    List<dynamic> users = [];
    if (stored != null && stored.isNotEmpty) {
      try {
        users = json.decode(stored) as List<dynamic>;
      } catch (_) {
        users = [];
      }
    }

    // Check duplicate email
    final bool exists = users.whereType<Map>().any(
      (u) => (u['email'] ?? '').toString() == email,
    );
    if (exists) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(24),
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text(
            'Email already registered',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
      return;
    }

    users.add(<String, String>{
      'name': name,
      'email': email,
      'password': password,
    });

    await prefs.setString('users', json.encode(users));

    if (!mounted) return;
    Navigator.pop(context); // return to Login
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            MyTextfield(
              controller: _nameController,
              hintText: 'name',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            MyTextfield(
              controller: _emailController,
              hintText: 'email',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            MyTextfield(
              controller: _passwordController,
              hintText: 'password',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryBtn(onTap: _saveUser, text: 'Login',),
          ],
        ),
      ),
    );
  }
}
