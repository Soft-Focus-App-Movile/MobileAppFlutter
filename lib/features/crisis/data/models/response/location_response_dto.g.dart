// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponseDto _$LocationResponseDtoFromJson(Map<String, dynamic> json) =>
    LocationResponseDto(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      displayString: json['displayString'] as String,
    );

Map<String, dynamic> _$LocationResponseDtoToJson(
  LocationResponseDto instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'displayString': instance.displayString,
};
