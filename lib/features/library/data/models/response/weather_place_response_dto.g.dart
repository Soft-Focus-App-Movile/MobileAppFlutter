// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_place_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherPlaceResponseDto _$WeatherPlaceResponseDtoFromJson(
  Map<String, dynamic> json,
) => WeatherPlaceResponseDto(
  weather: WeatherDto.fromJson(json['weather'] as Map<String, dynamic>),
  places: (json['places'] as List<dynamic>)
      .map((e) => ContentItemResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPlaces: (json['totalPlaces'] as num?)?.toInt(),
  location: json['location'] == null
      ? null
      : LocationDto.fromJson(json['location'] as Map<String, dynamic>),
  emotionFilter: json['emotionFilter'] as String?,
);

Map<String, dynamic> _$WeatherPlaceResponseDtoToJson(
  WeatherPlaceResponseDto instance,
) => <String, dynamic>{
  'weather': instance.weather,
  'places': instance.places,
  'totalPlaces': instance.totalPlaces,
  'location': instance.location,
  'emotionFilter': instance.emotionFilter,
};

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
  condition: json['condition'] as String,
  description: json['description'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
  cityName: json['cityName'] as String,
);

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'condition': instance.condition,
      'description': instance.description,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'cityName': instance.cityName,
    };
