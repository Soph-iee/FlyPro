import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/models/trip_status.dart';
import 'package:hive/hive.dart';

class TripProvider extends ChangeNotifier {
  final String _boxName = 'tripsBox';
  List<Trip> _myTrips = [];

  TripProvider() {
    getTrips();
  }

  void getTrips() async {
    var box = await Hive.openBox<Trip>(_boxName);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  List<Trip> get items {
    return _myTrips;
  }

  void addTrip(Trip trip) async {
    var box = await Hive.openBox<Trip>(_boxName);
    await box.add(trip);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  void removeTrip(int key) async {
    var box = await Hive.openBox<Trip>(_boxName);
    await box.delete(key);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  void clearTrips() async {
    var box = await Hive.openBox<Trip>(_boxName);
    await box.clear();
    _myTrips = box.values.toList();
    notifyListeners();
  }

  void updateTrip(Trip updatedTrip) async {
    var box = await Hive.openBox<Trip>(_boxName);
    await box.put(updatedTrip.key, updatedTrip);
    _myTrips = box.values.toList();
    notifyListeners();
  }

  List<Trip> pendingTrips() {
    var pendingTrips = _myTrips
        .where((trip) => trip.status == TripStatus.pending)
        .toList();
    return pendingTrips;
  }

  double get savings {
    return _myTrips.fold(0.0, (sum, trip) {
      return sum + (trip.budget - trip.totalSpent);
    });
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
    return expenses.toList();
  }
}
