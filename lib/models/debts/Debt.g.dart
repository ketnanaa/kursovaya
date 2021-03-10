// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Debt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtAdapter extends TypeAdapter<Debt> {
  @override
  final int typeId = 2;

  @override
  Debt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Debt(
      person: fields[2] as String,
      total: fields[4] as int,
      accumulations: fields[3] as int,
      debtType: fields[1] as DebtType,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Debt obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.debtType)
      ..writeByte(2)
      ..write(obj.person)
      ..writeByte(3)
      ..write(obj.accumulations)
      ..writeByte(4)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
