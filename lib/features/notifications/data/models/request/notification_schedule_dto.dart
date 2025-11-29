import 'package:json_annotation/json_annotation.dart';

part 'notification_schedule_dto.g.dart';

@JsonSerializable()
class NotificationScheduleDto {
  @JsonKey(name: 'start_time')
  final String startTime; // "HH:mm" format

  @JsonKey(name: 'end_time')
  final String endTime; // "HH:mm" format

  @JsonKey(name: 'days_of_week')
  final List<int> daysOfWeek; // 1-7

  const NotificationScheduleDto({
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
  });

  factory NotificationScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationScheduleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationScheduleDtoToJson(this);
}