// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crisis_alert_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrisisAlertResponseDto _$CrisisAlertResponseDtoFromJson(
  Map<String, dynamic> json,
) => CrisisAlertResponseDto(
  id: json['id'] as String,
  patientId: json['patientId'] as String,
  patientName: json['patientName'] as String,
  patientPhotoUrl: json['patientPhotoUrl'] as String?,
  psychologistId: json['psychologistId'] as String,
  severity: json['severity'] as String,
  status: json['status'] as String,
  triggerSource: json['triggerSource'] as String,
  triggerReason: json['triggerReason'] as String?,
  location: json['location'] == null
      ? null
      : LocationResponseDto.fromJson(json['location'] as Map<String, dynamic>),
  emotionalContext: json['emotionalContext'] == null
      ? null
      : EmotionalContextResponseDto.fromJson(
          json['emotionalContext'] as Map<String, dynamic>,
        ),
  psychologistNotes: json['psychologistNotes'] as String?,
  createdAt: json['createdAt'] as String,
  attendedAt: json['attendedAt'] as String?,
  resolvedAt: json['resolvedAt'] as String?,
);

Map<String, dynamic> _$CrisisAlertResponseDtoToJson(
  CrisisAlertResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'patientId': instance.patientId,
  'patientName': instance.patientName,
  'patientPhotoUrl': instance.patientPhotoUrl,
  'psychologistId': instance.psychologistId,
  'severity': instance.severity,
  'status': instance.status,
  'triggerSource': instance.triggerSource,
  'triggerReason': instance.triggerReason,
  'location': instance.location,
  'emotionalContext': instance.emotionalContext,
  'psychologistNotes': instance.psychologistNotes,
  'createdAt': instance.createdAt,
  'attendedAt': instance.attendedAt,
  'resolvedAt': instance.resolvedAt,
};
