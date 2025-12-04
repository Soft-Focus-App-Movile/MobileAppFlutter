import 'package:json_annotation/json_annotation.dart';
import '../../../../crisis/domain/models/crisis_alert.dart';
import 'location_response_dto.dart';
import 'emotional_context_response_dto.dart';

part 'crisis_alert_response_dto.g.dart';

@JsonSerializable()
class CrisisAlertResponseDto {
  final String id;
  final String patientId;
  final String patientName;
  final String? patientPhotoUrl;
  final String psychologistId;
  final String severity;
  final String status;
  final String triggerSource;
  final String? triggerReason;
  final LocationResponseDto? location;
  final EmotionalContextResponseDto? emotionalContext;
  final String? psychologistNotes;
  final String createdAt;
  final String? attendedAt;
  final String? resolvedAt;

  CrisisAlertResponseDto({
    required this.id,
    required this.patientId,
    required this.patientName,
    this.patientPhotoUrl,
    required this.psychologistId,
    required this.severity,
    required this.status,
    required this.triggerSource,
    this.triggerReason,
    this.location,
    this.emotionalContext,
    this.psychologistNotes,
    required this.createdAt,
    this.attendedAt,
    this.resolvedAt,
  });

  factory CrisisAlertResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CrisisAlertResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CrisisAlertResponseDtoToJson(this);

  CrisisAlert toDomain() {
    return CrisisAlert(
      id: id,
      patientId: patientId,
      patientName: patientName,
      patientPhotoUrl: patientPhotoUrl,
      psychologistId: psychologistId,
      severity: severity,
      status: status,
      triggerSource: triggerSource,
      triggerReason: triggerReason,
      location: location?.toDomain(),
      emotionalContext: emotionalContext?.toDomain(),
      psychologistNotes: psychologistNotes,
      createdAt: createdAt,
      attendedAt: attendedAt,
      resolvedAt: resolvedAt,
    );
  }
}
