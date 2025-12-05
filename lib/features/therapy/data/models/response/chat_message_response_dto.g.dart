// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageResponseDto _$ChatMessageResponseDtoFromJson(
  Map<String, dynamic> json,
) => ChatMessageResponseDto(
  id: json['id'] as String,
  relationshipId: json['relationshipId'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  content: json['content'],
  timestamp: json['timestamp'] as String,
  isRead: json['isRead'] as bool,
  messageType: json['messageType'] as String,
);

Map<String, dynamic> _$ChatMessageResponseDtoToJson(
  ChatMessageResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'relationshipId': instance.relationshipId,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'content': instance.content,
  'timestamp': instance.timestamp,
  'isRead': instance.isRead,
  'messageType': instance.messageType,
};