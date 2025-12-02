// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipDto _$RelationshipDtoFromJson(Map<String, dynamic> json) =>
    RelationshipDto(
      id: json['id'] as String,
      psychologistId: json['psychologistId'] as String,
      patientId: json['patientId'] as String,
      startDate: json['startDate'] as String,
      status: json['status'] as String,
      isActive: json['isActive'] as bool,
      sessionCount: (json['sessionCount'] as num).toInt(),
    );

Map<String, dynamic> _$RelationshipDtoToJson(RelationshipDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'psychologistId': instance.psychologistId,
      'patientId': instance.patientId,
      'startDate': instance.startDate,
      'status': instance.status,
      'isActive': instance.isActive,
      'sessionCount': instance.sessionCount,
    };
