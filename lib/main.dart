import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/category.dart';
import 'package:flypro_expense_tracker/models/currency.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/models/trip_status.dart';
import 'package:flypro_expense_tracker/providers/app_provider.dart';
import 'package:flypro_expense_tracker/screens/home/home_screen.dart';
import 'package:flypro_expense_tracker/screens/splash_screen.dart';
import 'package:flypro_expense_tracker/screens/trips/all_trips.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CurrencyAdapter());
  Hive.registerAdapter(TripStatusAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox<Trip>('tripsBox');
  await Hive.openBox<Expense>('expensesBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/trips': (context) => const AllTrips(),
      },

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
