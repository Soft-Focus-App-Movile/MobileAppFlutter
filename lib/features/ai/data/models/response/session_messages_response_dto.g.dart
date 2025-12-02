// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_messages_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionMessagesResponseDto _$SessionMessagesResponseDtoFromJson(
  Map<String, dynamic> json,
) => SessionMessagesResponseDto(
  sessionId: json['sessionId'] as String,
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatMessageItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SessionMessagesResponseDtoToJson(
  SessionMessagesResponseDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'messages': instance.messages,
};
