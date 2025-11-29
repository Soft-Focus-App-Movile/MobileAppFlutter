import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/entities/notification_type.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/delivery_status.dart';

part 'notification_response_dto.g.dart';

@JsonSerializable()
class NotificationResponseDto {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String content;
  final String priority;
  final String status;
  final String deliveryMethod;
  final String? scheduledAt;
  final String? deliveredAt;
  final String? readAt;
  final String createdAt;
  final Map<String, String>? metadata;

  const NotificationResponseDto({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.content,
    required this.priority,
    required this.status,
    required this.deliveryMethod,
    this.scheduledAt,
    this.deliveredAt,
    this.readAt,
    required this.createdAt,
    this.metadata,
  });

  factory NotificationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseDtoToJson(this);

  Notification toDomain() {
    try {
      DateTime? parseDateTime(String? dateStr) {
        if (dateStr == null) return null;
        try {
          return DateTime.parse(dateStr);
        } catch (_) {
          return null;
        }
      }

      return Notification(
        id: id,
        userId: userId,
        type: NotificationType.fromJson(type),
        title: title,
        content: content,
        priority: Priority.fromJson(priority),
        status: DeliveryStatus.fromJson(status),
        scheduledAt: parseDateTime(scheduledAt),
        deliveredAt: parseDateTime(deliveredAt),
        readAt: parseDateTime(readAt),
        createdAt: parseDateTime(createdAt) ?? DateTime.now(),
        metadata: metadata ?? {},
      );
    } catch (e) {
      // Notificación por defecto si falla el mapeo
      return Notification(
        id: id,
        userId: userId,
        type: NotificationType.info,
        title: title,
        content: content,
        priority: Priority.normal,
        status: DeliveryStatus.pending,
        createdAt: DateTime.now(),
        metadata: {},
      );
    }
  }
}