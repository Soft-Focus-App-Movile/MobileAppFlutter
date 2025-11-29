// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationScheduleDto _$NotificationScheduleDtoFromJson(
  Map<String, dynamic> json,
) => NotificationScheduleDto(
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  daysOfWeek: (json['days_of_week'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$NotificationScheduleDtoToJson(
  NotificationScheduleDto instance,
) => <String, dynamic>{
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'days_of_week': instance.daysOfWeek,
};
