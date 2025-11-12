import 'package:hive/hive.dart';

part 'trip_status.g.dart'; // This file will be generated

@HiveType(typeId: 3) // Unique typeId for the enum
enum TripStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  completed,
  @HiveField(2)
  pending,
}

