import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordFlow {
  static Future<void> handleForgotPassword(BuildContext context) async {
    final String? email = await _promptEmail(context);
    if (email == null || email.trim().isEmpty) return;
    final String? newPass = await _promptNewPassword(context);
    if (newPass == null || newPass.isEmpty) return;
    final bool ok = await _resetPasswordForEmail(email, newPass);
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ok ? 'Password reset' : 'Email not found'),
      ),
    );
  }

  static Future<List<Map<String, dynamic>>> _loadUsersFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? stored = prefs.getString('users');
    if (stored == null || stored.isEmpty) return [];
    final List<dynamic> data = json.decode(stored) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().toList();
  }

  static Future<void> _saveUsersToPrefs(
    List<Map<String, dynamic>> users,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('users', json.encode(users));
  }

  static Future<bool> _resetPasswordForEmail(
    String email,
    String newPassword,
  ) async {
    final List<Map<String, dynamic>> users = await _loadUsersFromPrefs();
    final String normalized = email.trim().toLowerCase();
    final int index = users.indexWhere(
      (u) => (u['email'] ?? '').toString().toLowerCase() == normalized,
    );
    if (index == -1) return false;
    users[index]['password'] = newPassword;
    await _saveUsersToPrefs(users);
    return true;
  }

  static Future<String?> _promptEmail(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter your email'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'email'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  static Future<String?> _promptNewPassword(BuildContext context) async {
    final controller = TextEditingController();
    bool obscure = true;
    return showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New password'),
          content: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: 'new password',
              suffixIcon: IconButton(
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => obscure = !obscure),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
