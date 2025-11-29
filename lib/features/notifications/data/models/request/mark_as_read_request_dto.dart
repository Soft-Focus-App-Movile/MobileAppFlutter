  import 'package:json_annotation/json_annotation.dart';

  part 'mark_as_read_request_dto.g.dart';

  @JsonSerializable()
  class MarkAsReadRequestDto {
    @JsonKey(name: 'notification_id')
    final String notificationId;

    const MarkAsReadRequestDto({required this.notificationId});

    factory MarkAsReadRequestDto.fromJson(Map<String, dynamic> json) =>
        _$MarkAsReadRequestDtoFromJson(json);

    Map<String, dynamic> toJson() => _$MarkAsReadRequestDtoToJson(this);
  }