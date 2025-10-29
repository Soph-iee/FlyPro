import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flypro_expense_tracker/layout.dart';
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
      home: const Layout(),
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
