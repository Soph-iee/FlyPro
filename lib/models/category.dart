import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart'; // This file will be generated

@HiveType(typeId: 4) // Unique typeId for the enum
enum Category {
  @HiveField(0)
  travel,
  @HiveField(1)
  transport,
  @HiveField(2)
  accomodation,
  @HiveField(3)
  meals,
  @HiveField(4)
  other,
}
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


