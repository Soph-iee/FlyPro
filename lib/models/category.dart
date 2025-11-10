import 'package:hive/hive.dart';

part 'category.g.dart'; // This file will be generated

@HiveType(typeId: 4) // Unique typeId for the enum
enum Category {
  @HiveField(0)
  travel,
  @HiveField(1)
  transport,
  @HiveField(2)
  accommodation,
  @HiveField(3)
  meals,
  @HiveField(4)
  other,
}


