// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginResponseDataAdapter extends TypeAdapter<LoginResponseData> {
  @override
  final int typeId = 0;

  @override
  LoginResponseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginResponseData(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      email: fields[2] as String?,
      countryCode: fields[3] as String?,
      countryNumber: fields[4] as String?,
      dob: fields[5] as String?,
      profileImage: fields[6] as String?,
      id: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginResponseData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.countryCode)
      ..writeByte(4)
      ..write(obj.countryNumber)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.profileImage)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      countryCode: json['country_code'] as String?,
      countryNumber: json['country_number'] as String?,
      dob: json['dob'] as String?,
      profileImage: json['profile_image'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('country_code', instance.countryCode);
  writeNotNull('country_number', instance.countryNumber);
  writeNotNull('dob', instance.dob);
  writeNotNull('profile_image', instance.profileImage);
  writeNotNull('id', instance.id);
  return val;
}
