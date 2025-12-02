import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/models/therapeutic_relationship.dart';

part 'relationship_dto.g.dart';

@JsonSerializable()
class RelationshipDto {
  final String id;
  final String psychologistId;
  final String patientId;
  final String startDate;
  final String status;
  final bool isActive;
  final int sessionCount;

  const RelationshipDto({
    required this.id,
    required this.psychologistId,
    required this.patientId,
    required this.startDate,
    required this.status,
    required this.isActive,
    required this.sessionCount,
  });

  factory RelationshipDto.fromJson(Map<String, dynamic> json) =>
      _$RelationshipDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RelationshipDtoToJson(this);

  TherapeuticRelationship toDomain() {
    return TherapeuticRelationship(
      id: id,
      psychologistId: psychologistId,
      patientId: patientId,
      startDate: startDate,
      status: status,
      isActive: isActive,
      sessionCount: sessionCount,
    );
  }
}
