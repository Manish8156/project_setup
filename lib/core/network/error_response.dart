import 'package:json_annotation/json_annotation.dart';
part 'error_response.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ErrorResponse {
  final int? code;
  final String? message;

  ErrorResponse({
    this.code,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
