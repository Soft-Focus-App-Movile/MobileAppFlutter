import 'package:json_annotation/json_annotation.dart';

part 'get_relationship_with_patient_response_dto.g.dart';

@JsonSerializable()
class GetRelationshipWithPatientResponseDto {
  final String relationshipId;

  const GetRelationshipWithPatientResponseDto({
    required this.relationshipId,
  });

  factory GetRelationshipWithPatientResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetRelationshipWithPatientResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetRelationshipWithPatientResponseDtoToJson(this);
}
