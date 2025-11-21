import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/users.dart';
import 'package:flypro_expense_tracker/providers/app_provider.dart';
import 'package:flypro_expense_tracker/screens/Expense/all_expenses.dart';
import 'package:flypro_expense_tracker/screens/trips/new_trip.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/widgets/card_container.dart';
import 'package:flypro_expense_tracker/widgets/expense_item.dart';
import 'package:flypro_expense_tracker/screens/Expense/new_expense_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.user});

  final UserModel? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // sign out function
  Future<void> _signUserOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  final now = DateTime.now();

  // floating action button condition
  bool _showOptions = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      listen: true,
      context,
    );
    AppProvider expenseProvider = Provider.of<AppProvider>(
      listen: true,
      context,
    );
    List<Expense> myExpense = expenseProvider.expenseItems
        .where((expense) => expense.userId == widget.user!.id)
        .toList();

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
                      widget.user!.name,
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
                  amount: appProvider.totalExpense.toInt(),
                  iconData: Icons.trending_down,
                ),

                CardContainer(
                  cardText: 'Trip',
                  amount: appProvider.tripItems.length,
                  iconData: Icons.flight_takeoff,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardContainer(
                  cardText: 'Pending',
                  amount: appProvider.pendingTrips().length,
                  iconData: Icons.travel_explore,
                ),

                CardContainer(
                  cardText: 'Savings',
                  amount: appProvider.savings.toInt(),
                  iconData: Icons.money,
                ),
              ],
            ),

            // recent expenses
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Expenses',
                  style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => AllExpensesPage(
                          userId: widget.user!.id,
                        ),
                      ),
                    );
                  },
                  iconSize: 32,
                  icon: const Icon(Icons.expand_less_rounded),
                ),
              ],
            ),

            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: myExpense.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ExpenseItem(
                      expense: myExpense[index],
                    ),
                  );
                },
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewExpensePage(
                      userId: widget.user!.id,
                    ),
                  ),
                );
              },
              heroTag: 'expense',
              tooltip: 'Add Expense',
              label: const Text('Add Expense'),
              icon: const Icon(Icons.money),
            ),
            const SizedBox(height: 8),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NewTrip(
                      userId: widget.user!.id,
                    ),
                  ),
                );
              },
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Remove default padding
          children: <Widget>[
            // DrawerHeader or UserAccountsDrawerHeader for the top section
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'FLYPRO  Trip Expense Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // ListTile widgets for menu items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Receipts'),
              onTap: () {
                // Handle navigation or other actions
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle navigation or other actions
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Profile'),
              onTap: () {
                // Handle navigation or other actions
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text(' Help & Support'),
              onTap: () {
                // Handle navigation or other actions
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
