// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageRequestDto _$ChatMessageRequestDtoFromJson(
  Map<String, dynamic> json,
) => ChatMessageRequestDto(
  message: json['message'] as String,
  sessionId: json['sessionId'] as String?,
);

Map<String, dynamic> _$ChatMessageRequestDtoToJson(
  ChatMessageRequestDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'sessionId': instance.sessionId,
};
