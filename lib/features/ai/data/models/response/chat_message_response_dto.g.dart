// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageResponseDto _$ChatMessageResponseDtoFromJson(
  Map<String, dynamic> json,
) => ChatMessageResponseDto(
  sessionId: json['sessionId'] as String,
  reply: json['reply'] as String,
  suggestedQuestions: (json['suggestedQuestions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  recommendedExercises: (json['recommendedExercises'] as List<dynamic>)
      .map((e) => ExerciseRecommendationDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  crisisDetected: json['crisisDetected'] as bool,
  timestamp: json['timestamp'] as String,
);

Map<String, dynamic> _$ChatMessageResponseDtoToJson(
  ChatMessageResponseDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'reply': instance.reply,
  'suggestedQuestions': instance.suggestedQuestions,
  'recommendedExercises': instance.recommendedExercises,
  'crisisDetected': instance.crisisDetected,
  'timestamp': instance.timestamp,
};
