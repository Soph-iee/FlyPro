

import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/category.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:hive/hive.dart';

class ExpenseProvider extends ChangeNotifier {
  final String _boxName = 'expensesBox';

  List<Expense> _myExpense = [];
  ExpenseProvider() {
    getExpense();
  }

  void getExpense() async {
    var box = await Hive.openBox<Expense>(_boxName);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  List<Expense> get items {
    return _myExpense;
  }

  void addExpense(Expense expense) async {
    var box = await Hive.openBox<Expense>(_boxName);
    await box.add(expense);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  void removeExpense(int key) async {
    var box = await Hive.openBox<Expense>(_boxName);
    await box.delete(key);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  void updateExpense(Expense updatedExpense) async {
    var box = await Hive.openBox<Expense>(_boxName);
    await box.put(updatedExpense.key, updatedExpense);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  void searchExpense(String query) {
    _myExpense = _myExpense
        .where(
          (e) =>
              e.description.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              e.category.name.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              e.notes!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    notifyListeners();
  }

  void clearExpenses() async {
    var box = await Hive.openBox<Expense>(_boxName);
    await box.clear();
    _myExpense = box.values.toList();
    notifyListeners();
  }

  void searchCategory(Category category) {
    _myExpense = _myExpense.where((e) => e.category == category).toList();
    notifyListeners();
  }

  double get totalExpense {
    return _myExpense.fold(0.0, (sum, item) => sum + item.amount);
  }

  List<Expense> activeExpenseForTrip(String tripId) {
    return _myExpense.where((expense) => expense.tripId == tripId).toList();
  }

  int get expenseCount {
    return _myExpense.length;
  }
}
