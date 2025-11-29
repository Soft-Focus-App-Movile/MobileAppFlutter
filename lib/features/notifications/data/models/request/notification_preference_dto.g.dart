// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preference_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferenceDto _$NotificationPreferenceDtoFromJson(
  Map<String, dynamic> json,
) => NotificationPreferenceDto(
  notificationType: json['notification_type'] as String,
  isEnabled: json['is_enabled'] as bool,
  schedule: json['schedule'] == null
      ? null
      : NotificationScheduleDto.fromJson(
          json['schedule'] as Map<String, dynamic>,
        ),
  deliveryMethod: json['delivery_method'] as String,
);

Map<String, dynamic> _$NotificationPreferenceDtoToJson(
  NotificationPreferenceDto instance,
) => <String, dynamic>{
  'notification_type': instance.notificationType,
  'is_enabled': instance.isEnabled,
  'schedule': instance.schedule,
  'delivery_method': instance.deliveryMethod,
};
