// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_completed_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentCompletedResponseDto _$AssignmentCompletedResponseDtoFromJson(
  Map<String, dynamic> json,
) => AssignmentCompletedResponseDto(
  assignmentId: json['assignmentId'] as String,
  completedAt: json['completedAt'] as String,
  message: json['message'] as String?,
);

Map<String, dynamic> _$AssignmentCompletedResponseDtoToJson(
  AssignmentCompletedResponseDto instance,
) => <String, dynamic>{
  'assignmentId': instance.assignmentId,
  'completedAt': instance.completedAt,
  'message': instance.message,
};
