import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/chat_message.dart';

part 'chat_message_response_dto.g.dart';

@JsonSerializable()
class ChatMessageResponseDto {
  final String id;
  
  // ELIMINADO: @JsonKey(name: 'relationship_id')
  final String relationshipId; 
  
  // ELIMINADO: @JsonKey(name: 'sender_id')
  final String senderId;
  
  // ELIMINADO: @JsonKey(name: 'receiver_id')
  final String receiverId;

  final dynamic content; 
  final String timestamp;
  
  // ELIMINADO: @JsonKey(name: 'is_read')
  final bool isRead;
  
  // ELIMINADO: @JsonKey(name: 'message_type')
  final String messageType;

  ChatMessageResponseDto({
    required this.id,
    required this.relationshipId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
    required this.messageType,
  });

  factory ChatMessageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseDtoFromJson(json);

  ChatMessage toDomain() {
    // Manejo de MessageContent si viene anidado
    String messageContent = '';
    if (content is Map) {
      messageContent = content['value'] ?? '';
    } else {
      messageContent = content.toString();
    }

    return ChatMessage(
      id: id,
      relationshipId: relationshipId,
      senderId: senderId,
      receiverId: receiverId,
      content: messageContent,
      timestamp: DateTime.parse(timestamp),
      isRead: isRead,
      messageType: messageType,
    );
  }
}