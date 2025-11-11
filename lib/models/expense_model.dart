import 'package:flypro_expense_tracker/models/category.dart';
import 'package:flypro_expense_tracker/models/currency.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


part 'expense_model.g.dart';


// enum Currency { usd, ngn, cad, gbp, eur }


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
