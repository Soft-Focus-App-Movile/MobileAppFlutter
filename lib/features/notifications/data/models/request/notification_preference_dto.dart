import 'package:json_annotation/json_annotation.dart';
import 'notification_schedule_dto.dart';

part 'notification_preference_dto.g.dart';

@JsonSerializable()
class NotificationPreferenceDto {
  @JsonKey(name: 'notification_type')
  final String notificationType;

  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  @JsonKey(name: 'schedule')
  final NotificationScheduleDto? schedule;

  @JsonKey(name: 'delivery_method')
  final String deliveryMethod;

  const NotificationPreferenceDto({
    required this.notificationType,
    required this.isEnabled,
    this.schedule,
    required this.deliveryMethod,
  });

  factory NotificationPreferenceDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferenceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPreferenceDtoToJson(this);
}