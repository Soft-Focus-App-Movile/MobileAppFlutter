// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_directory_item_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientDirectoryItemResponseDto _$PatientDirectoryItemResponseDtoFromJson(
  Map<String, dynamic> json,
) => PatientDirectoryItemResponseDto(
  id: json['id'] as String,
  psychologistId: json['psychologistId'] as String,
  patientId: json['patientId'] as String,
  patientName: json['patientName'] as String,
  age: (json['age'] as num).toInt(),
  profilePhotoUrl: json['profilePhotoUrl'] as String,
  status: (json['status'] as num).toInt(),
  startDate: json['startDate'] as String,
  sessionCount: (json['sessionCount'] as num).toInt(),
  lastSessionDate: json['lastSessionDate'] as String?,
);

Map<String, dynamic> _$PatientDirectoryItemResponseDtoToJson(
  PatientDirectoryItemResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'psychologistId': instance.psychologistId,
  'patientId': instance.patientId,
  'patientName': instance.patientName,
  'age': instance.age,
  'profilePhotoUrl': instance.profilePhotoUrl,
  'status': instance.status,
  'startDate': instance.startDate,
  'sessionCount': instance.sessionCount,
  'lastSessionDate': instance.lastSessionDate,
};
