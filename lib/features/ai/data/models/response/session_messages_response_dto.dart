import 'package:json_annotation/json_annotation.dart';
import 'chat_message_item_dto.dart';

part 'session_messages_response_dto.g.dart';

@JsonSerializable()
class SessionMessagesResponseDto {
  final String sessionId;
  final List<ChatMessageItemDto> messages;

  const SessionMessagesResponseDto({
    required this.sessionId,
    required this.messages,
  });

  factory SessionMessagesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SessionMessagesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SessionMessagesResponseDtoToJson(this);
}
