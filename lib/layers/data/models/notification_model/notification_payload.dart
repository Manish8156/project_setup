import 'package:json_annotation/json_annotation.dart';
part 'notification_payload.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false, fieldRename: FieldRename.snake)
class NotificationPayload {
  String? action;
  NotificationPayloadData? payloadData;

  NotificationPayload({
    this.action,
    this.payloadData,
  });

  factory NotificationPayload.fromJson(Map<String, dynamic> json) => _$NotificationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPayloadToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false, fieldRename: FieldRename.snake)
class NotificationPayloadData {
  String? title;
  String? message;

  NotificationPayloadData({
    this.title,
    this.message,
  });

  factory NotificationPayloadData.fromJson(Map<String, dynamic> json) => _$NotificationPayloadDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPayloadDataToJson(this);
}
