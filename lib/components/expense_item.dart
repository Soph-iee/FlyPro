import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: const Icon(
        Icons.lunch_dining,
        size: 24,
        fontWeight: FontWeight.bold,
      ),
      title: Text(
        expense.description,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      subtitle: Text(
        expense.formattedDate,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Text(
        expense.amount.toString(),
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF6D1E18),
        ),
      ),
    );
  }
}
