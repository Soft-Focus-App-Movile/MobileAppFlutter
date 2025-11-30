// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignments_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentsResponseDto _$AssignmentsResponseDtoFromJson(
  Map<String, dynamic> json,
) => AssignmentsResponseDto(
  assignments: (json['assignments'] as List<dynamic>)
      .map((e) => AssignmentResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  pending: (json['pending'] as num).toInt(),
  completed: (json['completed'] as num).toInt(),
);

Map<String, dynamic> _$AssignmentsResponseDtoToJson(
  AssignmentsResponseDto instance,
) => <String, dynamic>{
  'assignments': instance.assignments,
  'total': instance.total,
  'pending': instance.pending,
  'completed': instance.completed,
};
