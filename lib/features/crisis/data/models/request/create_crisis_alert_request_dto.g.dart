// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_crisis_alert_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCrisisAlertRequestDto _$CreateCrisisAlertRequestDtoFromJson(
  Map<String, dynamic> json,
) => CreateCrisisAlertRequestDto(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CreateCrisisAlertRequestDtoToJson(
  CreateCrisisAlertRequestDto instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
