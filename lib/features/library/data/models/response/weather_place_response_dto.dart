import 'package:json_annotation/json_annotation.dart';
import 'content_item_response_dto.dart';

part 'weather_place_response_dto.g.dart';

/// DTO para respuesta de recomendación de lugares con información del clima
@JsonSerializable()
class WeatherPlaceResponseDto {
  final WeatherDto weather;
  final List<ContentItemResponseDto> places;
  final int? totalPlaces;
  final LocationDto? location;
  final String? emotionFilter;

  const WeatherPlaceResponseDto({
    required this.weather,
    required this.places,
    this.totalPlaces,
    this.location,
    this.emotionFilter,
  });

  factory WeatherPlaceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherPlaceResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherPlaceResponseDtoToJson(this);
}

/// DTO para información de ubicación
@JsonSerializable()
class LocationDto {
  final double latitude;
  final double longitude;

  const LocationDto({
    required this.latitude,
    required this.longitude,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}

/// DTO interno para información del clima
@JsonSerializable()
class WeatherDto {
  final String condition;
  final String description;
  final double temperature;
  final int humidity;
  final String cityName;

  const WeatherDto({
    required this.condition,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.cityName,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);
}
