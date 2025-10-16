enum Currency { usd, ngn }

enum Category { travel, meals, accomodation, transport, other }

class Expense {
  Expense({
    required this.id,
    required this.amount,
    required this.currency,
    required this.category,
    required this.description,
    required this.date,
  });
  final String id;
  final double amount;
  final Currency currency;
  final Category category;
  final String description;
  final DateTime date;
}
