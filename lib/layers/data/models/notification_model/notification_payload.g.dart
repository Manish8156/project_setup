// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPayload _$NotificationPayloadFromJson(Map<String, dynamic> json) =>
    NotificationPayload(
      action: json['action'] as String?,
      payloadData: json['payload_data'] == null
          ? null
          : NotificationPayloadData.fromJson(
              json['payload_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationPayloadToJson(NotificationPayload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('action', instance.action);
  writeNotNull('payload_data', instance.payloadData?.toJson());
  return val;
}

NotificationPayloadData _$NotificationPayloadDataFromJson(
        Map<String, dynamic> json) =>
    NotificationPayloadData(
      title: json['title'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NotificationPayloadDataToJson(
    NotificationPayloadData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('message', instance.message);
  return val;
}
