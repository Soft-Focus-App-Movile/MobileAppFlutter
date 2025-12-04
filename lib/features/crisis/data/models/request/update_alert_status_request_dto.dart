import 'package:json_annotation/json_annotation.dart';

part 'update_alert_status_request_dto.g.dart';

@JsonSerializable()
class UpdateAlertStatusRequestDto {
  final String status;

  UpdateAlertStatusRequestDto({
    required this.status,
  });

  factory UpdateAlertStatusRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateAlertStatusRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAlertStatusRequestDtoToJson(this);
}
