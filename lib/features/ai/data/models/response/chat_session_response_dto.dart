import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/chat_session.dart';

part 'chat_session_response_dto.g.dart';

@JsonSerializable()
class ChatSessionResponseDto {
  final String sessionId;
  final String startedAt;
  final String lastMessageAt;
  final int messageCount;
  final bool isActive;
  final String? lastMessagePreview;

  const ChatSessionResponseDto({
    required this.sessionId,
    required this.startedAt,
    required this.lastMessageAt,
    required this.messageCount,
    required this.isActive,
    this.lastMessagePreview,
  });

  factory ChatSessionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSessionResponseDtoToJson(this);

  ChatSession toDomain() {
    return ChatSession(
      sessionId: sessionId,
      startedAt: _parseDateTime(startedAt),
      lastMessageAt: _parseDateTime(lastMessageAt),
      messageCount: messageCount,
      isActive: isActive,
      lastMessagePreview: lastMessagePreview,
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
