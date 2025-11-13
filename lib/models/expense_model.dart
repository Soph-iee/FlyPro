import 'dart:typed_data';

import 'package:flypro_expense_tracker/models/category.dart';
import 'package:flypro_expense_tracker/models/currency.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'expense_model.g.dart';

final uuid = const Uuid();

final formatter = DateFormat.yMMMd();
final digitFormatter = NumberFormat('#,###.##');

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final Currency currency;
  @HiveField(3)
  final String tripId;
  @HiveField(4)
  final Category category;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final DateTime date;
  @HiveField(7)
  String? notes;
  @HiveField(8)
  Uint8List? image;

  Expense({
    required this.amount,
    required this.currency,
    required this.tripId,
    required this.category,
    required this.description,
    required this.date,
    this.notes,
    this.image,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }

  String get formattedAmount {
    return digitFormatter.format(amount);
  }
}
