import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/notification_schedule.dart';

part 'schedule_dto.g.dart';

@JsonSerializable()
class ScheduleDto {
  @JsonKey(name: 'start_time')
  final String startTime;

  @JsonKey(name: 'end_time')
  final String endTime;

  @JsonKey(name: 'days_of_week')
  final List<int>? daysOfWeek;

  const ScheduleDto({
    required this.startTime,
    required this.endTime,
    this.daysOfWeek,
  });

  factory ScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDtoToJson(this);

  NotificationSchedule toDomain() {
    TimeOfDay parseTime(String time) {
      try {
        final parts = time.split(':');
        return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      } catch (e) {
        return const TimeOfDay(hour: 9, minute: 0);
      }
    }

    return NotificationSchedule(
      startTime: parseTime(startTime),
      endTime: parseTime(endTime),
      daysOfWeek: daysOfWeek ?? [1, 2, 3, 4, 5, 6, 7],
    );
  }
}