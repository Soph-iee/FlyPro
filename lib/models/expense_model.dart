import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { travel, meals, accomodation, transport, other }

enum Currency { usd, ngn, cad, gbp, eur }

const categoryIcons = {
  Category.travel: Icons.flight_takeoff,
  Category.meals: Icons.dining_sharp,
  Category.accomodation: Icons.hotel,
  Category.transport: Icons.local_taxi,
  Category.other: Icons.category,
};
final uuid = const Uuid();

final formatter = DateFormat.yMMMd();
final digitFormatter = NumberFormat('#,###.##');

class Expense {
  Expense({
    required this.amount,
    required this.currency,
    required this.tripId,
    required this.category,
    required this.description,
    required this.date,
    this.notes,
  }) : id = uuid.v4();

  final String id;
  final int amount;
  final Currency currency;
  final String tripId;
  final Category category;
  final String description;
  final DateTime date;
  String? notes;

  String get formattedDate {
    return formatter.format(date);
  }

  String get formattedAmount {
    return digitFormatter.format(amount);
  }
}
