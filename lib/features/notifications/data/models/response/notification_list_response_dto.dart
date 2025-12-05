import 'package:json_annotation/json_annotation.dart';
import 'notification_response_dto.dart';

part 'notification_list_response_dto.g.dart';

@JsonSerializable()
class NotificationListResponseDto {
  @JsonKey(name: 'notifications', defaultValue: [])
  final List<NotificationResponseDto> notifications;
  
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  
  @JsonKey(name: 'page', defaultValue: 1)
  final int page;
  
  @JsonKey(name: 'pageSize', defaultValue: 20)
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
