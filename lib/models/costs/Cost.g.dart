// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cost.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CostAdapter extends TypeAdapter<Cost> {
  @override
  final int typeId = 0;

  @override
  Cost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cost(
      label: fields[0] as String,
      value: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Cost obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
