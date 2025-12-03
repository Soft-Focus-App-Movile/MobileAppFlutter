// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_chat_message_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendChatMessageRequestDto _$SendChatMessageRequestDtoFromJson(
  Map<String, dynamic> json,
) => SendChatMessageRequestDto(
  relationshipId: json['relationshipId'] as String,
  receiverId: json['receiverId'] as String,
  content: json['content'] as String,
  messageType: json['messageType'] as String? ?? 'text',
);

Map<String, dynamic> _$SendChatMessageRequestDtoToJson(
  SendChatMessageRequestDto instance,
) => <String, dynamic>{
  'relationshipId': instance.relationshipId,
  'receiverId': instance.receiverId,
  'content': instance.content,
  'messageType': instance.messageType,
};
