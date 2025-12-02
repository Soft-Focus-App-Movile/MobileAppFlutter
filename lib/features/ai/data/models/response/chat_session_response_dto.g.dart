// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSessionResponseDto _$ChatSessionResponseDtoFromJson(
  Map<String, dynamic> json,
) => ChatSessionResponseDto(
  sessionId: json['sessionId'] as String,
  startedAt: json['startedAt'] as String,
  lastMessageAt: json['lastMessageAt'] as String,
  messageCount: (json['messageCount'] as num).toInt(),
  isActive: json['isActive'] as bool,
  lastMessagePreview: json['lastMessagePreview'] as String?,
);

Map<String, dynamic> _$ChatSessionResponseDtoToJson(
  ChatSessionResponseDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'startedAt': instance.startedAt,
  'lastMessageAt': instance.lastMessageAt,
  'messageCount': instance.messageCount,
  'isActive': instance.isActive,
  'lastMessagePreview': instance.lastMessagePreview,
};
