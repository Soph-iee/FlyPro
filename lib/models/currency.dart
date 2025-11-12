import 'package:hive/hive.dart';

part 'currency.g.dart'; // This file will be generated

@HiveType(typeId: 2) // Unique typeId for the enum
enum Currency {
  @HiveField(0)
  ngn,
  @HiveField(1)
  usd,
  @HiveField(2)
  eur,
  @HiveField(3)
  gbp,
}
extension CurrencyExtension on Currency {
  String get symbol {
    switch (this) {
      case Currency.ngn:
        return '₦';
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      }
  }
}