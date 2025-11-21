// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 1;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      desription: fields[3] as String,
      budget: fields[2] as double,
      name: fields[1] as String,
      destination: fields[4] as String,
      endDate: fields[6] as DateTime,
      startDate: fields[5] as DateTime,
      currency: fields[8] as Currency,
      expenseCount: fields[7] as int,
      status: fields[9] as TripStatus,
      totalSpent: fields[10] as double,
      userId: fields[11] as String,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.budget)
      ..writeByte(3)
      ..write(obj.desription)
      ..writeByte(4)
      ..write(obj.destination)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.expenseCount)
      ..writeByte(8)
      ..write(obj.currency)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.totalSpent)
      ..writeByte(11)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
