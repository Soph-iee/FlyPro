import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/users.dart';
import 'package:flypro_expense_tracker/screens/charts/line_bar_chart.dart';
import 'package:flypro_expense_tracker/screens/home/home_screen.dart';
import 'package:flypro_expense_tracker/screens/receipt_screen.dart';
import 'package:flypro_expense_tracker/screens/trips/all_trips.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.user});

  final UserModel user;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late List screens = [
    const HomeScreen(),
     AllTrips(userId: widget.user.id ,),
    const ExpenseChartScreen(),
    const ReceiptScreen(),
  ];

  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    screens[0] = HomeScreen(user: widget.user);
    return Scaffold(
      body: screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,

        onTap: (int index) {
          setState(() {
            _currentScreen = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'trips',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Charts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Receipts',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
