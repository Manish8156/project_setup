import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';

part 'base_response_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
  genericArgumentFactories: true,
)
class BaseResponseModel<T> {
  final T? data;
  final Meta? meta;

  BaseResponseModel({
    this.data,
    this.meta,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseResponseModelToJson(this, toJsonT);
}
