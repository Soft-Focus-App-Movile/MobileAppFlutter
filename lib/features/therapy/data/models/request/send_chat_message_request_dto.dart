import 'package:json_annotation/json_annotation.dart';

part 'send_chat_message_request_dto.g.dart';

@JsonSerializable()
class SendChatMessageRequestDto {
  final String relationshipId;
  final String receiverId;
  final String content;
  final String messageType;

  SendChatMessageRequestDto({
    required this.relationshipId,
    required this.receiverId,
    required this.content,
    this.messageType = 'text',
  });

  Map<String, dynamic> toJson() => _$SendChatMessageRequestDtoToJson(this);
}