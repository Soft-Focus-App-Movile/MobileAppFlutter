import 'package:json_annotation/json_annotation.dart';

part 'chat_message_request_dto.g.dart';

@JsonSerializable()
class ChatMessageRequestDto {
  final String message;
  final String? sessionId;

  const ChatMessageRequestDto({
    required this.message,
    this.sessionId,
  });

  Map<String, dynamic> toJson() => _$ChatMessageRequestDtoToJson(this);
}
