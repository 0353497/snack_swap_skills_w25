// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradeAdapter extends TypeAdapter<Trade> {
  @override
  final int typeId = 2;

  @override
  Trade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trade(
      fields[0] as User,
      fields[1] as Snack,
      fields[2] as User,
      fields[3] as Snack,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Trade obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fromUser)
      ..writeByte(1)
      ..write(obj.fromUserSnack)
      ..writeByte(2)
      ..write(obj.toUser)
      ..writeByte(3)
      ..write(obj.toUserSnack)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
