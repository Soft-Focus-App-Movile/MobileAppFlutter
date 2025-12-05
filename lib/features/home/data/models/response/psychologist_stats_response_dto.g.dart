// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psychologist_stats_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychologistStatsResponseDto _$PsychologistStatsResponseDtoFromJson(
  Map<String, dynamic> json,
) => PsychologistStatsResponseDto(
  activePatientsCount: (json['activePatientsCount'] as num).toInt(),
  pendingCrisisAlerts: (json['pendingCrisisAlerts'] as num).toInt(),
  todayCheckInsCompleted: (json['todayCheckInsCompleted'] as num).toInt(),
  averageAdherenceRate: (json['averageAdherenceRate'] as num).toDouble(),
  newPatientsThisMonth: (json['newPatientsThisMonth'] as num).toInt(),
  averageEmotionalLevel: (json['averageEmotionalLevel'] as num).toDouble(),
  statsGeneratedAt: json['statsGeneratedAt'] as String,
);

Map<String, dynamic> _$PsychologistStatsResponseDtoToJson(
  PsychologistStatsResponseDto instance,
) => <String, dynamic>{
  'activePatientsCount': instance.activePatientsCount,
  'pendingCrisisAlerts': instance.pendingCrisisAlerts,
  'todayCheckInsCompleted': instance.todayCheckInsCompleted,
  'averageAdherenceRate': instance.averageAdherenceRate,
  'newPatientsThisMonth': instance.newPatientsThisMonth,
  'averageEmotionalLevel': instance.averageEmotionalLevel,
  'statsGeneratedAt': instance.statsGeneratedAt,
};
