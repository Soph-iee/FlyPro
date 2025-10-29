import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:intl/intl.dart';

final fomatter = DateFormat.yMMMd();

class Trip {
  Trip({
    required this.desription,
    required this.budget,
    required this.name,
    required this.destination,
    required this.endDate,
    required this.startDate,
    required this.currency,
    required this.expenseCount,
    required this.status,
    required this.totalSpent,
  });
  String? id;
  final String name;
  final double budget;
  final String desription;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int expenseCount;
  final Currency currency;
  final String status;
  final double totalSpent;

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }
}
