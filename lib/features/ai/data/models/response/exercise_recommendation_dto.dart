import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/exercise_recommendation.dart';

part 'exercise_recommendation_dto.g.dart';

@JsonSerializable()
class ExerciseRecommendationDto {
  final String id;
  final String title;
  final String duration;

  const ExerciseRecommendationDto({
    required this.id,
    required this.title,
    required this.duration,
  });

  factory ExerciseRecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$ExerciseRecommendationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseRecommendationDtoToJson(this);

  ExerciseRecommendation toDomain() {
    return ExerciseRecommendation(
      id: id,
      title: title,
      duration: duration,
    );
  }
}
