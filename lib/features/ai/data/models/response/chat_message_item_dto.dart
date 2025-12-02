import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/chat_message.dart';
import '../../../domain/models/message_role.dart';

part 'chat_message_item_dto.g.dart';

@JsonSerializable()
class ChatMessageItemDto {
  final String role;
  final String content;
  final String timestamp;
  final List<String> suggestedQuestions;

  const ChatMessageItemDto({
    required this.role,
    required this.content,
    required this.timestamp,
    this.suggestedQuestions = const [],
  });

  factory ChatMessageItemDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageItemDtoToJson(this);

  ChatMessage toDomain() {
    return ChatMessage(
      role: role == 'user' ? MessageRole.user : MessageRole.assistant,
      content: content,
      timestamp: _parseDateTime(timestamp),
      suggestedQuestions: suggestedQuestions,
    );
  }

  DateTime _parseDateTime(String dateTimeStr) {
    try {
      return DateTime.parse(dateTimeStr);
    } catch (e) {
      return DateTime.now();
    }
  }
}
