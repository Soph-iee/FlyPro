import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/card_container.dart';
import 'package:flypro_expense_tracker/components/expense_item.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/screens/Expense/new_expense_page.dart';
// import 'package:flypro_expense_tracker/components/expense_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  add new expense function
  void _addNewExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewExpensePage(onAddExpense: _updateExpenseList),
      ),
    );
  }

  void _updateExpenseList(Expense expense) {
    setState(() {
      _myExpenses.add(expense);
    });
  }

  // sign out function
  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final now = DateTime.now();

  final List<Expense> _myExpenses = [
    Expense(
      amount: 20,
      description: 'Silk scarf',
      date: DateTime.now(),
      category: Category.other,
    ),
    Expense(
      amount: 240,
      description: 'Lunch at Italian restaurant',
      date: DateTime.now(),
      category: Category.meals,
    ),
    Expense(
      category: Category.accomodation,
      amount: 300,
      description: 'Women Confrence',
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9fafb),
      appBar: AppBar(
        backgroundColor: const Color(0xff2563eb),
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
                    const Text(
                      'John Doe',
                      style: TextStyle(
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
            const Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardContainer(
                  cardText: 'Expenses',
                  amount: 18800,
                  iconData: Icons.trending_down,
                ),

                CardContainer(
                  cardText: 'Trip',
                  amount: 1,
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
            const Text(
              'Recent Expenses',
              style: TextStyle(fontSize: 24),
            ),

            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: _myExpenses.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: ExpenseItem(expense: _myExpenses[index]),
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewExpense,
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'trips',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'expense',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'budget',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
      drawer: const Drawer(),
    );
  }
}
