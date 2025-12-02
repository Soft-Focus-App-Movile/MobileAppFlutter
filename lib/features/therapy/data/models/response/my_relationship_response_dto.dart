import 'package:json_annotation/json_annotation.dart';
import 'relationship_dto.dart';

part 'my_relationship_response_dto.g.dart';

@JsonSerializable()
class MyRelationshipResponseDto {
  final bool hasRelationship;
  final RelationshipDto? relationship;

  const MyRelationshipResponseDto({
    required this.hasRelationship,
    this.relationship,
  });

  factory MyRelationshipResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MyRelationshipResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MyRelationshipResponseDtoToJson(this);
}
