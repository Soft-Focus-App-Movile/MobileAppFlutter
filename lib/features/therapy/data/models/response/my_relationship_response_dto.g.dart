// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_relationship_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRelationshipResponseDto _$MyRelationshipResponseDtoFromJson(
  Map<String, dynamic> json,
) => MyRelationshipResponseDto(
  hasRelationship: json['hasRelationship'] as bool,
  relationship: json['relationship'] == null
      ? null
      : RelationshipDto.fromJson(json['relationship'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MyRelationshipResponseDtoToJson(
  MyRelationshipResponseDto instance,
) => <String, dynamic>{
  'hasRelationship': instance.hasRelationship,
  'relationship': instance.relationship,
};
