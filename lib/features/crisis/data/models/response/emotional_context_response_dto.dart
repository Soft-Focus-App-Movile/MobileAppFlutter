import 'package:json_annotation/json_annotation.dart';
import '../../../../crisis/domain/models/crisis_alert.dart';

part 'emotional_context_response_dto.g.dart';

@JsonSerializable()
class EmotionalContextResponseDto {
  final String? lastDetectedEmotion;
  final String? lastEmotionDetectedAt;
  final String? emotionSource;

  EmotionalContextResponseDto({
    this.lastDetectedEmotion,
    this.lastEmotionDetectedAt,
    this.emotionSource,
  });

  factory EmotionalContextResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EmotionalContextResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmotionalContextResponseDtoToJson(this);

  EmotionalContext toDomain() {
    return EmotionalContext(
      lastDetectedEmotion: lastDetectedEmotion,
      lastEmotionDetectedAt: lastEmotionDetectedAt,
      emotionSource: emotionSource,
    );
  }
}
