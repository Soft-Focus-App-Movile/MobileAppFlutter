import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/models/chat_message.dart';
import '../../../../domain/models/message_role.dart';
import 'exercise_recommendation_dto.dart';

part 'chat_message_response_dto.g.dart';

@JsonSerializable()
class ChatMessageResponseDto {
  final String sessionId;
  final String reply;
  final List<String> suggestedQuestions;
  final List<ExerciseRecommendationDto> recommendedExercises;
  final bool crisisDetected;
  final String timestamp;

  const ChatMessageResponseDto({
    required this.sessionId,
    required this.reply,
    required this.suggestedQuestions,
    required this.recommendedExercises,
    required this.crisisDetected,
    required this.timestamp,
  });

  factory ChatMessageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageResponseDtoToJson(this);

  ChatMessage toDomain() {
    return ChatMessage(
      role: MessageRole.assistant,
      content: reply,
      timestamp: _parseTimestamp(timestamp),
      suggestedQuestions: suggestedQuestions,
      recommendedExercises: recommendedExercises.map((e) => e.toDomain()).toList(),
      crisisDetected: crisisDetected,
    );
  }

  DateTime _parseTimestamp(String timestamp) {
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return DateTime.now();
    }
  }
}
