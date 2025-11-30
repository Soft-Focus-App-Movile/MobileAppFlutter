import 'package:json_annotation/json_annotation.dart';
import 'assignment_response_dto.dart';

part 'assignments_response_dto.g.dart';

/// DTO para respuesta que contiene lista de asignaciones del backend
@JsonSerializable()
class AssignmentsResponseDto {
  final List<AssignmentResponseDto> assignments;
  final int total;
  final int pending;
  final int completed;

  const AssignmentsResponseDto({
    required this.assignments,
    required this.total,
    required this.pending,
    required this.completed,
  });

  factory AssignmentsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AssignmentsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentsResponseDtoToJson(this);
}
