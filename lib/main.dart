import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/screens/pages/auth_gate.dart';
import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: const MyApp(),
      create: (context) => ExpenseProvider(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      home: const AuthGate(),
      title: 'expense tracker',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: ColorScheme.light(
          surface: const Color(
            0xfff9fafb,
          ),
          error: const Color(0xffef4444),
          onSurface: const Color(0xff111827),
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xff10b981),
          outline: Colors.grey[500],
        ),
      ),
    );
  }
}
