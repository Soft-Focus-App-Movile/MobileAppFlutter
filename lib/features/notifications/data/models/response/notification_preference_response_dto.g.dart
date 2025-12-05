// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preference_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferenceResponseDto _$NotificationPreferenceResponseDtoFromJson(
  Map<String, dynamic> json,
) => NotificationPreferenceResponseDto(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  notificationType: json['notification_type'] as String,
  isEnabled: json['is_enabled'] as bool? ?? true,
  schedule: json['schedule'] == null
      ? null
      : ScheduleDto.fromJson(json['schedule'] as Map<String, dynamic>),
  deliveryMethod: json['delivery_method'] as String,
  disabledAt: json['disabled_at'] as String?,
);

Map<String, dynamic> _$NotificationPreferenceResponseDtoToJson(
  NotificationPreferenceResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'notification_type': instance.notificationType,
  'is_enabled': instance.isEnabled,
  'schedule': instance.schedule,
  'delivery_method': instance.deliveryMethod,
  'disabled_at': instance.disabledAt,
};
