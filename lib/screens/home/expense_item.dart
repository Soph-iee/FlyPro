import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense, required this.currency});

  final Expense expense;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      tileColor: Colors.blue[50],
      onTap: () {},
      leading: Icon(
        categoryIcons[expense.category],
        size: 24,
        fontWeight: FontWeight.bold,
      ),
      title: Text(
        expense.description,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        expense.formattedDate,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Text(
        '$currency ${expense.amount}',
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF6D1E18),
        ),
      ),
    );
  }
}
