// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userID: fields[0] as String,
      name: fields[1] as String,
      password: fields[2] as String,
      country: fields[3] as String,
      countryImgUrl: fields[4] as String?,
      isLoggedIn: fields[7] as bool,
      profileImg: fields[5] as String?,
      tradedSnacks: (fields[6] as List?)?.cast<Snack>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.countryImgUrl)
      ..writeByte(5)
      ..write(obj.profileImg)
      ..writeByte(6)
      ..write(obj.tradedSnacks)
      ..writeByte(7)
      ..write(obj.isLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
