import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/card_container.dart';
import 'package:flypro_expense_tracker/components/expense_item.dart';
import 'package:flypro_expense_tracker/models/expense.dart';
import 'package:flypro_expense_tracker/pages/new_expense_page.dart';
// import 'package:flypro_expense_tracker/components/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    print(_myExpenses);
  }

  // sign out function
  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final now = DateTime.now();

  final List<Expense> _myExpenses = [
    Expense(amount: 20, description: 'Silk scarf', date: DateTime.now()),
    Expense(
      amount: 240,
      description: 'Lunch at Italian restaurant',
      date: DateTime.now(),
    ),
    Expense(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
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

            // the cards
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardContainer(
                    cardText: 'expenses',
                    amount: 12,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  CardContainer(
                    cardText: 'trip',
                    amount: 8,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardContainer(
                    cardText: 'pending',
                    amount: 32,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  CardContainer(
                    cardText: 'savings',
                    amount: 2840,
                  ),
                ],
              ),
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
                itemBuilder: (context, index) =>
                    ExpenseItem(expense: _myExpenses[index]),
              ),
            ),

            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _addNewExpense,
                    child: const Text('add new expense'),
                  ),

                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('add new trip'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
