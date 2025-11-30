import 'package:json_annotation/json_annotation.dart';

part 'assignment_created_response_dto.g.dart';

/// DTO para respuesta de asignación exitosa (devuelve IDs)
@JsonSerializable()
class AssignmentCreatedResponseDto {
  final List<String> assignmentIds;
  final String? message;

  const AssignmentCreatedResponseDto({
    required this.assignmentIds,
    this.message,
  });

  factory AssignmentCreatedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCreatedResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentCreatedResponseDtoToJson(this);
}
