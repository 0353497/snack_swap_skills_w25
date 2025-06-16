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
      total: fields[2] as int,
      country: fields[4] as String,
      currentUser: fields[3] as String,
      countryImgUrl: fields[6] as String?,
      imageImgUrl: fields[5] as String?,
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
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.currentUser)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.imageImgUrl)
      ..writeByte(6)
      ..write(obj.countryImgUrl);
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
