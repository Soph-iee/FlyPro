import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:intl/intl.dart';

final List<Expense> myExpenses = [
  Expense(
    amount: 2000,
    description: 'Silk scarf',
    date: DateTime.now(),
    category: Category.other,
    currency: Currency.usd,
    tripId: 'paris',
  ),
  Expense(
    amount: 240,
    description: 'Lunch at Italian restaurant',
    date: DateTime.now(),
    category: Category.meals,
    currency: Currency.ngn,
    tripId: 'bali',
  ),
  Expense(
    category: Category.accomodation,
    amount: 300,
    description: 'Women Confrence',
    date: DateTime.now(),
    currency: Currency.eur,
    tripId: 'zanzibar',
  ),

  Expense(
    category: Category.transport,
    amount: 150,
    description: 'Airport taxi to villa',
    date: DateTime.now(),
    currency: Currency.usd,
    tripId: 'Bali',
  ),

  Expense(
    category: Category.meals,
    amount: 75,
    description: 'Dinner at beachside café',
    date: DateTime.now(),
    currency: Currency.usd,
    tripId: 'Bali',
  ),

  Expense(
    category: Category.other,
    amount: 40,
    description: 'Snacks and drinks for family',
    date: DateTime.now(),
    currency: Currency.ngn,
    tripId: 'Lagos',
  ),

  Expense(
    category: Category.transport,
    amount: 25,
    description: 'Bus fare around city',
    date: DateTime.now(),
    currency: Currency.ngn,
    tripId: 'Lagos',
  ),

  Expense(
    category: Category.travel,
    amount: 120,
    description: 'Louvre Museum ticket',
    date: DateTime.now(),
    currency: Currency.eur,
    tripId: 'Paris',
  ),

  Expense(
    category: Category.meals,
    amount: 65,
    description: 'Lunch at street café',
    date: DateTime.now(),
    currency: Currency.eur,
    tripId: 'Paris',
    notes: 'Tried local baguette and espresso',
  ),

  Expense(
    category: Category.accomodation,
    amount: 220,
    description: 'Two-night stay at resort',
    date: DateTime.now(),
    currency: Currency.usd,
    tripId: 'Zanzibar',
    notes: 'Got a sea-view room at a discount',
  ),

  Expense(
    category: Category.other,
    amount: 8000,
    description: 'Boat tour and snorkeling',
    date: DateTime.now(),
    currency: Currency.usd,
    tripId: 'Zanzibar',
    notes: 'Saw dolphins and coral reefs',
  ),

  Expense(
    category: Category.transport,
    amount: 100,
    description: 'Train ride to mountain lodge',
    date: DateTime.now(),
    currency: Currency.eur,
    tripId: 'Swiss Alps',
    notes: 'Scenic ride through snowy mountains',
  ),

  Expense(
    category: Category.meals,
    amount: 45,
    description: 'Dinner at alpine restaurant',
    date: DateTime.now(),
    currency: Currency.eur,
    tripId: 'Swiss Alps',
    notes: 'Had cheese fondue with locals',
  ),
  Expense(
    category: Category.other,
    amount: 300,
    description: 'Mall souvenirs and clothes',
    date: DateTime.now(),
    currency: Currency.usd,
    tripId: 'Dubai',
    notes: 'Bought gifts and traditional attire',
  ),

  Expense(
    category: Category.meals,
    amount: 90,
    description: 'Dinner at rooftop restaurant',
    date: DateTime.now(),
    currency: Currency.usd,
    tripId: 'Dubai',
    notes: 'Enjoyed skyline view at sunset',
  ),
];

String formatNumber(num number) {
  final formatter = NumberFormat('#,###'); 
  return formatter.format(number);
}

int totalExpense() {
  int sum = 0;
  for (final item in myExpenses) {
    sum += item.amount;
  }

  return sum;
}
