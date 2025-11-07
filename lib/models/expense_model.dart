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

final categoryColors = {
  Category.meals: Colors.orange,
  Category.transport: Colors.blue,
  Category.travel: Colors.pink,
  Category.accomodation: Colors.green, 
  Category.other: Colors.grey,
};

final uuid = const Uuid();

final formatter = DateFormat.yMMMd();
final digitFormatter = NumberFormat('#,###.##');

class Expense {
  final String id;
  final int amount;
  final Currency currency;
  final String tripId;
  final Category category;
  final String description;
  final DateTime date;
  String? notes;

  Expense({
    required this.amount,
    required this.currency,
    required this.tripId,
    required this.category,
    required this.description,
    required this.date,
    this.notes,
  }) : id = uuid.v4();

  Expense copyWith({
    int? amount,
    String? description,
    DateTime? date,
    Category? category,
    Currency? currency,
    String? tripId,
    String? notes,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      tripId: tripId ?? this.tripId,
      notes: notes ?? this.notes,
    );
  }

  String get formattedDate {
    return formatter.format(date);
  }

  String get formattedAmount {
    return digitFormatter.format(amount);
  }
}
