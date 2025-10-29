import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/widgets/expense_detail.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;
  void _showDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ExpenseDetail(
          expense: expense,
        ),
      ),
    );
  }

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
      onTap: () {
        _showDetails(context);
      },
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
        '${expense.currency.name.toUpperCase()} ${expense.amount}',
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF6D1E18),
        ),
      ),
    );
  }
}
