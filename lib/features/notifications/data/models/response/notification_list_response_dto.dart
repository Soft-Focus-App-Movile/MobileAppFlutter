import 'package:json_annotation/json_annotation.dart';
import 'notification_response_dto.dart';

part 'notification_list_response_dto.g.dart';

@JsonSerializable()
class NotificationListResponseDto {
  final List<NotificationResponseDto> notifications;
  final int total;
  final int page;
  final int pageSize;

  const NotificationListResponseDto({
    required this.notifications,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory NotificationListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListResponseDtoToJson(this);
}