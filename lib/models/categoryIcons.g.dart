// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryIcons.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryiconsAdapter extends TypeAdapter<Categoryicons> {
  @override
  final int typeId = 1;

  @override
  Categoryicons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categoryicons(
      icon: fields[0] as int,
      name: fields[1] as String,
      color: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Categoryicons obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.icon)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryiconsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
