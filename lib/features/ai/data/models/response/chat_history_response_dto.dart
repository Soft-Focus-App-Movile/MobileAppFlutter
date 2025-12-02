import 'package:json_annotation/json_annotation.dart';
import 'chat_session_response_dto.dart';

part 'chat_history_response_dto.g.dart';

@JsonSerializable()
class ChatHistoryResponseDto {
  final List<ChatSessionResponseDto> sessions;
  final int totalCount;

  const ChatHistoryResponseDto({
    required this.sessions,
    required this.totalCount,
  });

  factory ChatHistoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatHistoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatHistoryResponseDtoToJson(this);
}
