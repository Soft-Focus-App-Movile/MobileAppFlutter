// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_created_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentCreatedResponseDto _$AssignmentCreatedResponseDtoFromJson(
  Map<String, dynamic> json,
) => AssignmentCreatedResponseDto(
  assignmentIds: (json['assignmentIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AssignmentCreatedResponseDtoToJson(
  AssignmentCreatedResponseDto instance,
) => <String, dynamic>{
  'assignmentIds': instance.assignmentIds,
  'message': instance.message,
};
