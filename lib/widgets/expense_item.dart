import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:flypro_expense_tracker/screens/Expense/new_expense_page.dart';
import 'package:flypro_expense_tracker/widgets/expense_detail.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
  });

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
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context);
    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.green[100],
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Row(
          children: [
            Icon(Icons.edit, color: Colors.green),
            SizedBox(width: 8),
            Text('Edit'),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red[100],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Delete'),
            SizedBox(width: 8),
            Icon(Icons.delete, color: Colors.red),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NewExpensePage(
                expense: expense,
              ),
            ),
          );
          return false; // don't dismiss on edit
        }
        return true; // allow dismiss on delete (endToStart)
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          expenseProvider.removeExpense(expense.key);
        }
      },
      child: ListTile(
        key: ValueKey(expense),
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
          '${expense.currency.name.toUpperCase()} ${expense.formattedAmount}',
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF6D1E18),
          ),
        ),
      ),
    );
  }
}
