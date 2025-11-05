import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:flypro_expense_tracker/screens/Expense/all_expenses.dart';
import 'package:flypro_expense_tracker/screens/trips/new_trip.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/data/dummy_expenses.dart';
import 'package:flypro_expense_tracker/data/dummy_trips.dart';
import 'package:flypro_expense_tracker/widgets/card_container.dart';
import 'package:flypro_expense_tracker/widgets/expense_item.dart';
import 'package:flypro_expense_tracker/screens/Expense/new_expense_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.userName});

  final String? userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  add new expense function
  void _addNewExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewExpensePage(),
      ),
    );
  }

  // adding new trip button function
  void _addNewtrip() async {
    final newTripItem =
        await Navigator.of(
          context,
        ).push<Trip>(
          MaterialPageRoute(
            builder: (ctx) => const NewTrip(),
          ),
        );
    if (newTripItem == null) {
      return;
    }
    setState(() {
      myTrips.add(newTripItem);
    });
  }

  // updating expense list functi

  // sign out function
  Future<void> _signUserOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  final now = DateTime.now();
  int _totalExpense = 0;

  int _showTotalExpense() {
    setState(() {
      _totalExpense = totalExpense();
    });
    return _totalExpense;
  }

  // floating action button condition
  bool _showOptions = false;

  @override
  Widget build(BuildContext context) {
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xfff9fafb),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        animateColor: true,
        actions: [
          IconButton(onPressed: _signUserOut, icon: const Icon(Icons.logout)),
        ],
      ),

      // the home page body- welcome message
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(60),
                  child: Image.asset(
                    'assets/images/John.jpg',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Text(
                      widget.userName!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),
            // the cards
            Row(
              children: [
                CardContainer(
                  cardText: 'Expenses',
                  amount: _showTotalExpense(),
                  iconData: Icons.trending_down,
                ),

                CardContainer(
                  cardText: 'Trip',
                  amount: myTrips.length,
                  iconData: Icons.flight_takeoff,
                ),
              ],
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardContainer(
                  cardText: 'Pending',
                  amount: 5,
                  iconData: Icons.travel_explore,
                ),

                CardContainer(
                  cardText: 'Savings',
                  amount: 12840,
                  iconData: Icons.money,
                ),
              ],
            ),

            // recent expenses
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const AllExpensesPage(),
                  ),
                );
              },
              child: Text(
                'Recent Expenses',
                style: TextStyle(fontSize: 24, color: Colors.grey[600]),
              ),
            ),

            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: expenseProvider.items.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: ExpenseItem(
                    expense: expenseProvider.items[index],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showOptions) ...[
            FloatingActionButton.extended(
              onPressed: _addNewExpense,
              heroTag: 'expense',
              tooltip: 'Add Expense',
              label: const Text('Add Expense'),
              icon: const Icon(Icons.money),
            ),
            const SizedBox(height: 8),
            FloatingActionButton.extended(
              onPressed: _addNewtrip,
              heroTag: 'trip',
              tooltip: 'Add Trip',
              label: const Text('Add Trip'),
              icon: const Icon(Icons.flight_takeoff),
            ),
            const SizedBox(height: 24),
          ],
          FloatingActionButton(
            onPressed: () => setState(() {
              _showOptions = !_showOptions;
            }),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      drawer: const Drawer(),
    );
  }
}
