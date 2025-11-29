import 'package:flutter_app_softfocus/features/notifications/domain/entities/delivery_status.dart';
import 'package:flutter_app_softfocus/features/notifications/domain/entities/notification_type.dart';
import 'package:flutter_app_softfocus/features/notifications/domain/entities/priority.dart';

class Notification {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String content;
  final Priority priority;
  final DeliveryStatus status;
  final DateTime? scheduledAt;
  final DateTime? deliveredAt;
  final DateTime? readAt;
  final DateTime createdAt;
  final Map<String, String> metadata;

  const Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.content,
    required this.priority,
    required this.status,
    this.scheduledAt,
    this.deliveredAt,
    this.readAt,
    required this.createdAt,
    this.metadata = const {},
  });

  Notification copyWith({
    String? id,
    String? userId,
    NotificationType? type,
    String? title,
    String? content,
    Priority? priority,
    DeliveryStatus? status,
    DateTime? scheduledAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    DateTime? createdAt,
    Map<String, String>? metadata,
  }) {
    return Notification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata ?? this.metadata,
    );
  }

  bool get isRead => readAt != null;
  bool get isUnread => readAt == null;
}