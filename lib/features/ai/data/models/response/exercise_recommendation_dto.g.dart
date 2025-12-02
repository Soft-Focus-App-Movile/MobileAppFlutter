// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_recommendation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseRecommendationDto _$ExerciseRecommendationDtoFromJson(
  Map<String, dynamic> json,
) => ExerciseRecommendationDto(
  id: json['id'] as String,
  title: json['title'] as String,
  duration: json['duration'] as String,
);

Map<String, dynamic> _$ExerciseRecommendationDtoToJson(
  ExerciseRecommendationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'duration': instance.duration,
};
