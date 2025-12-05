import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/entities/notification_type.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/delivery_status.dart';

part 'notification_response_dto.g.dart';

@JsonSerializable()
class NotificationResponseDto {
  @JsonKey(name: 'id')
  final String id;
  
  @JsonKey(name: 'userId')
  final String userId;
  
  @JsonKey(name: 'type')
  final String type;
  
  @JsonKey(name: 'title')
  final String title;
  
  @JsonKey(name: 'content')
  final String content;
  
  @JsonKey(name: 'priority')
  final String priority;
  
  @JsonKey(name: 'status')
  final String status;
  
  @JsonKey(name: 'deliveryMethod')
  final String deliveryMethod;
  
  @JsonKey(name: 'scheduledAt')
  final String? scheduledAt;
  
  @JsonKey(name: 'deliveredAt')
  final String? deliveredAt;
  
  @JsonKey(name: 'readAt')
  final String? readAt;
  
  @JsonKey(name: 'createdAt')
  final String createdAt;
  
  @JsonKey(name: 'metadata')
  final Map<String, dynamic>? metadata;

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
        if (dateStr == null || dateStr.isEmpty) return null;
        try {
          // Intentar parsear ISO 8601
          return DateTime.parse(dateStr);
        } catch (e) {
          print('⚠️ Error parsing date: $dateStr - $e');
          return null;
        }
      }

      // Convertir metadata de Map<String, dynamic> a Map<String, String>
      Map<String, String> parseMetadata(Map<String, dynamic>? meta) {
        if (meta == null) return {};
        return meta.map((key, value) => MapEntry(key, value?.toString() ?? ''));
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
        metadata: parseMetadata(metadata),
      );
    } catch (e) {
      print('❌ Error mapping NotificationResponseDto to domain: $e');
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