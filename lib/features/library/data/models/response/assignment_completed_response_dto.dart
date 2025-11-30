import 'package:json_annotation/json_annotation.dart';

part 'assignment_completed_response_dto.g.dart';

/// DTO para respuesta de completar asignación
@JsonSerializable()
class AssignmentCompletedResponseDto {
  final String assignmentId;
  final String completedAt;
  final String? message;

  const AssignmentCompletedResponseDto({
    required this.assignmentId,
    required this.completedAt,
    this.message,
  });

  factory AssignmentCompletedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCompletedResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentCompletedResponseDtoToJson(this);
}
