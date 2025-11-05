import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/data/dummy_expenses.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _items = myExpenses;
  List<Expense> get items => _items;

  void addExpense(Expense expense) {
    _items.add(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _items.remove(expense);
    notifyListeners();
  }

  void updateExpense(String id, Expense newExpense) {
    final index = _items.indexWhere((exp) => exp.id == id);
    if (index >= 0) {
      _items[index] = newExpense;
      notifyListeners();
    }
  }
}
