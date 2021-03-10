// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DebtType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtTypeAdapter extends TypeAdapter<DebtType> {
  @override
  final int typeId = 1;

  @override
  DebtType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DebtType.deposit;
      case 1:
        return DebtType.loan;
      default:
        return DebtType.deposit;
    }
  }

  @override
  void write(BinaryWriter writer, DebtType obj) {
    switch (obj) {
      case DebtType.deposit:
        writer.writeByte(0);
        break;
      case DebtType.loan:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
