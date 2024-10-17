import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response_data.g.dart';

///
/// this is example of first Api calling with an retrofit.
@JsonSerializable(explicitToJson: true, includeIfNull: false, fieldRename: FieldRename.snake)
@HiveType(typeId: 0)
class LoginResponseData {
  @HiveField(0)
  final String? firstName;

  @HiveField(1)
  final String? lastName;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? countryCode;

  @HiveField(4)
  final String? countryNumber;

  @HiveField(5)
  final String? dob;

  @HiveField(6)
  final String? profileImage;

  @HiveField(7)
  final int? id;

  LoginResponseData({
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.countryNumber,
    this.dob,
    this.profileImage,
    this.id,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
