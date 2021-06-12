// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStateAdapter extends TypeAdapter<UserState> {
  @override
  final int typeId = 2;

  @override
  UserState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserState(
      isLoggedIn: fields[0] as bool,
      hasStartedConvoWithBot: fields[1] as bool,
      themeMode: fields[2] as String,
      loginType: fields[3] as String,
      hasOnboarded: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserState obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isLoggedIn)
      ..writeByte(1)
      ..write(obj.hasStartedConvoWithBot)
      ..writeByte(2)
      ..write(obj.themeMode)
      ..writeByte(3)
      ..write(obj.loginType)
      ..writeByte(4)
      ..write(obj.hasOnboarded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
