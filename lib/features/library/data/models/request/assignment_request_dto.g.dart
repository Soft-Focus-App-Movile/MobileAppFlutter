// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentRequestDto _$AssignmentRequestDtoFromJson(
  Map<String, dynamic> json,
) => AssignmentRequestDto(
  patientIds: (json['patientIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  contentId: json['contentId'] as String,
  contentType: json['contentType'] as String,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$AssignmentRequestDtoToJson(
  AssignmentRequestDto instance,
) => <String, dynamic>{
  'patientIds': instance.patientIds,
  'contentId': instance.contentId,
  'contentType': instance.contentType,
  'notes': instance.notes,
};
