// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotional_context_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmotionalContextResponseDto _$EmotionalContextResponseDtoFromJson(
  Map<String, dynamic> json,
) => EmotionalContextResponseDto(
  lastDetectedEmotion: json['lastDetectedEmotion'] as String?,
  lastEmotionDetectedAt: json['lastEmotionDetectedAt'] as String?,
  emotionSource: json['emotionSource'] as String?,
);

Map<String, dynamic> _$EmotionalContextResponseDtoToJson(
  EmotionalContextResponseDto instance,
) => <String, dynamic>{
  'lastDetectedEmotion': instance.lastDetectedEmotion,
  'lastEmotionDetectedAt': instance.lastEmotionDetectedAt,
  'emotionSource': instance.emotionSource,
};
