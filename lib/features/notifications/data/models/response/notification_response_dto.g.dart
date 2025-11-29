// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseDto _$NotificationResponseDtoFromJson(
  Map<String, dynamic> json,
) => NotificationResponseDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  priority: json['priority'] as String,
  status: json['status'] as String,
  deliveryMethod: json['deliveryMethod'] as String,
  scheduledAt: json['scheduledAt'] as String?,
  deliveredAt: json['deliveredAt'] as String?,
  readAt: json['readAt'] as String?,
  createdAt: json['createdAt'] as String,
  metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$NotificationResponseDtoToJson(
  NotificationResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': instance.type,
  'title': instance.title,
  'content': instance.content,
  'priority': instance.priority,
  'status': instance.status,
  'deliveryMethod': instance.deliveryMethod,
  'scheduledAt': instance.scheduledAt,
  'deliveredAt': instance.deliveredAt,
  'readAt': instance.readAt,
  'createdAt': instance.createdAt,
  'metadata': instance.metadata,
};
