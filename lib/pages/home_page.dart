import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/card_container.dart';
import 'package:flypro_expense_tracker/components/expense_item.dart';
// import 'package:flypro_expense_tracker/components/expense_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        animateColor: true,
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
        ],
      ),
      // the home page body- welcome message
      body: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome message',
              style: TextStyle(fontSize: 32),
            ),

            // the cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardContainer(cardText: 'expenses'),
                  CardContainer(cardText: 'trip'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardContainer(cardText: 'pending'),
                  CardContainer(cardText: 'savings'),
                ],
              ),
            ),
            // recent expenses
            SizedBox(
              height: 16,
            ),
            Text(
              'Recent Expenses',
              style: TextStyle(fontSize: 24),
            ),
            ExpenseItem(),
            ExpenseItem(),
            ExpenseItem(),
            ExpenseItem(),
            ExpenseItem(),
          ],
        ),
      ),
    );
  }
}
