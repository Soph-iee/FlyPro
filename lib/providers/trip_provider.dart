import 'package:flutter/material.dart';
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
    notifyListeners();
    return pendingTrips;
  }

  double get savings {
    double budgets = _myTrips.fold(0.0, (sum, item) => sum + item.budget);
    double totalSpents = _myTrips.fold(
      0.0,
      (sum, item) => sum + item.totalSpent,
    );

    return budgets - totalSpents;
  }
}
