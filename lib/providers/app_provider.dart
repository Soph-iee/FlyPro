import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/category.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/models/trip_status.dart';
import 'package:hive/hive.dart';

class AppProvider extends ChangeNotifier {
  final String _tripBox = 'tripsBox';
  final String _expenseBox = 'expensesBox';
  List<Trip> _myTrips = [];
  List<Expense> _myExpense = [];

  AppProvider() {
    getTrips();
    getExpense();
  }

  void getExpense() async {
    var box = await Hive.openBox<Expense>(_expenseBox);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  List<Expense> get expenseItems {
    return _myExpense;
  }

  List<Trip> get tripItems {
    return _myTrips;
  }

  void getTrips() async {
    var box = await Hive.openBox<Trip>(_tripBox);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  List<Expense> getImages() {
    var allImages = _myExpense
        .where((expense) => expense.image != null)
        .toList();
    notifyListeners();
    return allImages;
  }

  // retreiving images

  double get savings {
    return _myTrips.fold(0.0, (sum, trip) => sum + trip.budget) -
        _myTrips.fold(0.0, (sum, trip) => sum + trip.totalSpent);
  }

  void addTrip(Trip trip) async {
    var box = await Hive.openBox<Trip>(_tripBox);
    await box.add(trip);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  void removeTrip(int key) async {
    var box = await Hive.openBox<Trip>(_tripBox);
    await box.delete(key);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  void clearTrips() async {
    var box = await Hive.openBox<Trip>(_tripBox);
    await box.clear();
    _myTrips = box.values.toList();
    notifyListeners();
  }

  List<Trip> pendingTrips() {
    var pendingTrips = _myTrips
        .where((trip) => trip.status == TripStatus.pending)
        .toList();
    return pendingTrips;
  }

  List<Expense> expensesForTrip(String trip) {
    final expensesBox = Hive.box<Expense>('expensesBox');
    final expenses = expensesBox.values.where((e) => e.tripId == trip);
    final tripItem = _myTrips.firstWhere((t) => t.destination == trip);
    tripItem.totalSpent = expenses.toList().fold(
      0.0,
      (sum, item) => sum + item.amount,
    );
    tripItem.expenseCount = expenses.length;
    tripItem.save();
    notifyListeners();
    return expenses.toList();
  }

  void addExpense(Expense expense) async {
    var box = await Hive.openBox<Expense>(_expenseBox);
    await box.add(expense);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  void removeExpense(dynamic key) async {
    var box = await Hive.openBox<Expense>(_expenseBox);
    await box.delete(key);
    _myExpense = box.values.toList();
    notifyListeners();
  }

  void updateExpense(Expense updatedExpense, int key) async {
    var box = await Hive.openBox<Expense>(_expenseBox);
    await box.put(key, updatedExpense);
    updatedExpense.save();
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
    var box = await Hive.openBox<Expense>(_expenseBox);
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
