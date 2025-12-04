import 'package:json_annotation/json_annotation.dart';

part 'create_crisis_alert_request_dto.g.dart';

@JsonSerializable()
class CreateCrisisAlertRequestDto {
  final double? latitude;
  final double? longitude;

  CreateCrisisAlertRequestDto({
    this.latitude,
    this.longitude,
  });

  factory CreateCrisisAlertRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCrisisAlertRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCrisisAlertRequestDtoToJson(this);
}
