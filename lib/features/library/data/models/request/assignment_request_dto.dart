import 'package:json_annotation/json_annotation.dart';

part 'assignment_request_dto.g.dart';

/// DTO para solicitud de asignación de contenido
@JsonSerializable()
class AssignmentRequestDto {
  /// IDs de los pacientes a quienes asignar el contenido
  final List<String> patientIds;

  /// ID del contenido a asignar
  final String contentId;

  /// Tipo de contenido (Movie, Music, Video, Place)
  final String contentType;

  /// Notas opcionales del psicólogo
  final String? notes;

  const AssignmentRequestDto({
    required this.patientIds,
    required this.contentId,
    required this.contentType,
    this.notes,
  });

  factory AssignmentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AssignmentRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentRequestDtoToJson(this);
}
