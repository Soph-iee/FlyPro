import 'package:flypro_expense_tracker/models/currency.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_status.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'trip_model.g.dart';




final fomatter = DateFormat.yMMMd();
final digitFormatter = NumberFormat('#,###.##');

final uuid = const Uuid();

@HiveType(typeId: 1)
class Trip extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double budget;
  @HiveField(3)
  String desription;
  @HiveField(4)
  String destination;
  @HiveField(5)
  DateTime startDate;
  @HiveField(6)
  DateTime endDate;
  @HiveField(7)
  int? expenseCount;
  @HiveField(8)
  Currency currency;
  @HiveField(9)
  TripStatus status;
  @HiveField(10)
  double totalSpent;

  Trip({
    required this.desription,
    required this.budget,
    required this.name,
    required this.destination,
    required this.endDate,
    required this.startDate,
    required this.currency,
    this.expenseCount,
    required this.status,
    required this.totalSpent,
  }) : id = uuid.v4();

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }

  String get formattedAmount {
    return digitFormatter.format(budget);
  }
}
