import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      home: const AuthPage(),
      title: 'expense tracker',
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
    );
  }
}
