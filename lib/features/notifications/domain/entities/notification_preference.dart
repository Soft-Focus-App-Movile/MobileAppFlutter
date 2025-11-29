import 'package:flutter_app_softfocus/features/notifications/domain/entities/delivery_method.dart';
import 'package:flutter_app_softfocus/features/notifications/domain/entities/notification_schedule.dart';
import 'package:flutter_app_softfocus/features/notifications/domain/entities/notification_type.dart';

class NotificationPreference {
  final String id;
  final String userId;
  final NotificationType notificationType;
  final bool isEnabled;
  final DeliveryMethod deliveryMethod;
  final NotificationSchedule? schedule;
  final DateTime? disabledAt;

  const NotificationPreference({
    required this.id,
    required this.userId,
    required this.notificationType,
    required this.isEnabled,
    required this.deliveryMethod,
    this.schedule,
    this.disabledAt,
  });

  NotificationPreference copyWith({
    String? id,
    String? userId,
    NotificationType? notificationType,
    bool? isEnabled,
    DeliveryMethod? deliveryMethod,
    NotificationSchedule? schedule,
    DateTime? disabledAt,
  }) {
    return NotificationPreference(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      notificationType: notificationType ?? this.notificationType,
      isEnabled: isEnabled ?? this.isEnabled,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      schedule: schedule ?? this.schedule,
      disabledAt: disabledAt ?? this.disabledAt,
    );
  }
}