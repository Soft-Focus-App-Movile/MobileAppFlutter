// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentResponseDto _$AssignmentResponseDtoFromJson(
  Map<String, dynamic> json,
) => AssignmentResponseDto(
  assignmentId: json['assignmentId'] as String,
  psychologistId: json['psychologistId'] as String?,
  content: ContentItemResponseDto.fromJson(
    json['content'] as Map<String, dynamic>,
  ),
  notes: json['notes'] as String?,
  isCompleted: json['isCompleted'] as bool? ?? false,
  completedAt: json['completedAt'] as String?,
  assignedAt: json['assignedAt'] as String,
);

Map<String, dynamic> _$AssignmentResponseDtoToJson(
  AssignmentResponseDto instance,
) => <String, dynamic>{
  'assignmentId': instance.assignmentId,
  'psychologistId': instance.psychologistId,
  'content': instance.content,
  'notes': instance.notes,
  'isCompleted': instance.isCompleted,
  'completedAt': instance.completedAt,
  'assignedAt': instance.assignedAt,
};
