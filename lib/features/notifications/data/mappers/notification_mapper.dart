import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notification_schedule.dart';
import '../models/request/notification_schedule_dto.dart';

class NotificationMapper {
  /// Convierte TimeOfDay a String en formato HH:mm
  static String timeOfDayToString(TimeOfDay time) {
    final dateTime = DateTime(0, 1, 1, time.hour, time.minute);
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Convierte String HH:mm a TimeOfDay
  static TimeOfDay stringToTimeOfDay(String timeString) {
    try {
      final parts = timeString.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    } catch (e) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  /// Convierte NotificationSchedule del dominio a DTO
  static NotificationScheduleDto scheduleToDto(NotificationSchedule schedule) {
    return NotificationScheduleDto(
      startTime: timeOfDayToString(schedule.startTime),
      endTime: timeOfDayToString(schedule.endTime),
      daysOfWeek: schedule.daysOfWeek,
    );
  }

  /// Convierte DTO a NotificationSchedule del dominio
  static NotificationSchedule dtoToSchedule(NotificationScheduleDto dto) {
    return NotificationSchedule(
      startTime: stringToTimeOfDay(dto.startTime),
      endTime: stringToTimeOfDay(dto.endTime),
      daysOfWeek: dto.daysOfWeek,
    );
  }

  /// Formatea DateTime a String relativo (hace 2 horas, ayer, etc.)
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes <= 1) {
          return 'Ahora';
        }
        return '${difference.inMinutes} min';
      } else if (difference.inHours == 1) {
        return '1 hora';
      }
      return '${difference.inHours} horas';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  /// Formatea DateTime a formato completo
  static String formatDateTime(DateTime dateTime) {
    return DateFormat("dd/MM/yyyy 'a las' HH:mm").format(dateTime);
  }
}