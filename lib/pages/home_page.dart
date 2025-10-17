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

  @override
  Widget build(BuildContext context) {
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
            ExpenseItem(
              expense: Expense(
                amount: 23,
                category: Category.accomodation,
                currency: Currency.ngn,
                date: DateTime.now(),
                description: 'food at italian restaurant',
                id: 'one',
              ),
            ),
            ExpenseItem(
              expense: Expense(
                amount: 23,
                category: Category.accomodation,
                currency: Currency.ngn,
                date: DateTime.now(),
                description: 'food at italian restaurant',
                id: 'one',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
