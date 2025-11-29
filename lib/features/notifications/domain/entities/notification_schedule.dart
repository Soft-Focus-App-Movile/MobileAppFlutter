import 'package:flutter/material.dart';

class NotificationSchedule {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<int> daysOfWeek; // 1-7 (Lunes a Domingo)

  const NotificationSchedule({
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
  });

  NotificationSchedule copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<int>? daysOfWeek,
  }) {
    return NotificationSchedule(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }

  bool isWithinSchedule(TimeOfDay now) {
    final nowMinutes = now.hour * 60 + now.minute;
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    if (endMinutes > startMinutes) {
      return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    } else {
      // Horario cruza medianoche
      return nowMinutes >= startMinutes || nowMinutes < endMinutes;
    }
  }
}