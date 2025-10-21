import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Currency { usd, ngn }

enum Category { travel, meals, accomodation, transport, other }

const categoryIcons = {
  Category.travel: Icons.flight_takeoff,
  Category.meals: Icons.dining_sharp,
  Category.accomodation: Icons.hotel,
  Category.transport: Icons.local_taxi,
  Category.other: Icons.category,
};

final formatter = DateFormat.yMMMd();

class Expense {
  Expense({
    // required this.id,
    required this.amount,
    // required this.currency,
    required this.category,
    required this.description,
    required this.date,
  });

  // final String id;
  final int amount;
  // final Currency currency;
  final Category category;
  final String description;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}
