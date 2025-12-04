import 'package:json_annotation/json_annotation.dart';
import '../../../../crisis/domain/models/crisis_alert.dart';

part 'location_response_dto.g.dart';

@JsonSerializable()
class LocationResponseDto {
  final double? latitude;
  final double? longitude;
  final String displayString;

  LocationResponseDto({
    this.latitude,
    this.longitude,
    required this.displayString,
  });

  factory LocationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationResponseDtoToJson(this);

  Location toDomain() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      displayString: displayString,
    );
  }
}
