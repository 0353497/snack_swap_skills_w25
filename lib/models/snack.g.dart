// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackAdapter extends TypeAdapter<Snack> {
  @override
  final int typeId = 0;

  @override
  Snack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Snack(
      name: fields[0] as String,
      description: fields[1] as String,
      country: fields[3] as String,
      userID: fields[2] as String,
      countryImgUrl: fields[5] as String?,
      imageImgUrl: fields[4] as String?,
      haveTraded: (fields[6] as List?)?.cast<User>(),
    );
  }

  @override
  void write(BinaryWriter writer, Snack obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.userID)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.imageImgUrl)
      ..writeByte(5)
      ..write(obj.countryImgUrl)
      ..writeByte(6)
      ..write(obj.haveTraded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
