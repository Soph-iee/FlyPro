// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 4;

  @override
  Category read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Category.travel;
      case 1:
        return Category.transport;
      case 2:
        return Category.accommodation;
      case 3:
        return Category.meals;
      case 4:
        return Category.other;
      default:
        return Category.travel;
    }
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    switch (obj) {
      case Category.travel:
        writer.writeByte(0);
        break;
      case Category.transport:
        writer.writeByte(1);
        break;
      case Category.accommodation:
        writer.writeByte(2);
        break;
      case Category.meals:
        writer.writeByte(3);
        break;
      case Category.other:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
