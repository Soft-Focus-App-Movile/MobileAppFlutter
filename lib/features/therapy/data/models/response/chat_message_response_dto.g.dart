// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'chat_message_response_dto.dart';

ChatMessageResponseDto _$ChatMessageResponseDtoFromJson(Map<String, dynamic> json) =>
    ChatMessageResponseDto(
      id: json['id'] as String,
      relationshipId: json['relationship_id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      content: json['content'],
      timestamp: json['timestamp'] as String,
      isRead: json['is_read'] as bool,
      messageType: json['message_type'] as String,
    );

Map<String, dynamic> _$ChatMessageResponseDtoToJson(ChatMessageResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relationship_id': instance.relationshipId,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'content': instance.content,
      'timestamp': instance.timestamp,
      'is_read': instance.isRead,
      'message_type': instance.messageType,
    };