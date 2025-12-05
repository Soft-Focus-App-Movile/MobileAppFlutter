import 'package:flutter_app_softfocus/features/library/domain/models/assignment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'content_item_response_dto.dart';


part 'assignment_response_dto.g.dart';

/// DTO para respuesta de asignación del backend
@JsonSerializable()
class AssignmentResponseDto {
  final String assignmentId;

  /// Nullable porque el endpoint /by-psychologist no lo envía
  final String? psychologistId;

  final ContentItemResponseDto content;

  final String? notes;

  @JsonKey(defaultValue: false)
  final bool isCompleted;

  /// ISO 8601 format
  final String? completedAt;

  /// ISO 8601 format
  final String assignedAt;

  const AssignmentResponseDto({
    required this.assignmentId,
    this.psychologistId,
    required this.content,
    this.notes,
    required this.isCompleted,
    this.completedAt,
    required this.assignedAt,
  });

  factory AssignmentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AssignmentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentResponseDtoToJson(this);

  Assignment toDomain() {
    return Assignment(
      id: assignmentId,
      content: content.toDomain(),
      psychologistId: psychologistId,
      notes: notes,
      assignedDate: DateTime.parse(assignedAt),
      isCompleted: isCompleted,
      completedDate: completedAt != null ? DateTime.parse(completedAt!) : null,
    );
  }
}