import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/psychologist_stats.dart';

part 'psychologist_stats_response_dto.g.dart';

@JsonSerializable()
class PsychologistStatsResponseDto {
  @JsonKey(name: 'activePatientsCount')
  final int activePatientsCount;

  @JsonKey(name: 'pendingCrisisAlerts')
  final int pendingCrisisAlerts;

  @JsonKey(name: 'todayCheckInsCompleted')
  final int todayCheckInsCompleted;

  @JsonKey(name: 'averageAdherenceRate')
  final double averageAdherenceRate;

  @JsonKey(name: 'newPatientsThisMonth')
  final int newPatientsThisMonth;

  @JsonKey(name: 'averageEmotionalLevel')
  final double averageEmotionalLevel;

  @JsonKey(name: 'statsGeneratedAt')
  final String statsGeneratedAt;

  PsychologistStatsResponseDto({
    required this.activePatientsCount,
    required this.pendingCrisisAlerts,
    required this.todayCheckInsCompleted,
    required this.averageAdherenceRate,
    required this.newPatientsThisMonth,
    required this.averageEmotionalLevel,
    required this.statsGeneratedAt,
  });

  factory PsychologistStatsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PsychologistStatsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PsychologistStatsResponseDtoToJson(this);

  PsychologistStats toDomain() {
    return PsychologistStats(
      activePatientsCount: activePatientsCount,
      pendingCrisisAlerts: pendingCrisisAlerts,
      todayCheckInsCompleted: todayCheckInsCompleted,
      averageAdherenceRate: averageAdherenceRate,
      newPatientsThisMonth: newPatientsThisMonth,
      averageEmotionalLevel: averageEmotionalLevel,
      statsGeneratedAt: statsGeneratedAt,
    );
  }
}
