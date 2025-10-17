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
        builder: (context) => const NewExpensePage(),
      ),
    );
  }

  // sign out function
  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final now = DateTime.now();


  @override
  Widget build(BuildContext context) {

    // final List<Expense> _myExpe
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        animateColor: true,
        actions: [
          IconButton(onPressed: _signUserOut, icon: const Icon(Icons.logout)),
        ],
      ),
      // the home page body- welcome message
      body: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome message',
              style: TextStyle(fontSize: 32),
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
                itemCount: 2,
                itemBuilder: (context, index) => ExpenseItem(
                  expense: Expense(
                    amount: 23,
                    date: DateTime.now(),
                    description: 'Food at Italian restaurant',
                  ),
                ),
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
