// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyAdapter extends TypeAdapter<Currency> {
  @override
  final int typeId = 2;

  @override
  Currency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Currency.ngn;
      case 1:
        return Currency.usd;
      case 2:
        return Currency.eur;
      case 3:
        return Currency.gbp;
      default:
        return Currency.ngn;
    }
  }

  @override
  void write(BinaryWriter writer, Currency obj) {
    switch (obj) {
      case Currency.ngn:
        writer.writeByte(0);
        break;
      case Currency.usd:
        writer.writeByte(1);
        break;
      case Currency.eur:
        writer.writeByte(2);
        break;
      case Currency.gbp:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
