import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/notification_preference.dart';
import '../../../domain/entities/notification_type.dart';
import '../../../domain/entities/delivery_method.dart';
import 'schedule_dto.dart';

part 'notification_preference_response_dto.g.dart';

@JsonSerializable()
class NotificationPreferenceResponseDto {
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'notification_type')
  final String notificationType;

  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  final ScheduleDto? schedule;

  @JsonKey(name: 'delivery_method')
  final String deliveryMethod;

  @JsonKey(name: 'disabled_at')
  final String? disabledAt;

  const NotificationPreferenceResponseDto({
    required this.id,
    required this.userId,
    required this.notificationType,
    required this.isEnabled,
    this.schedule,
    required this.deliveryMethod,
    this.disabledAt,
  });

  factory NotificationPreferenceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferenceResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPreferenceResponseDtoToJson(this);

  NotificationPreference toDomain() {
    DateTime? parseDateTime(String? dateStr) {
      if (dateStr == null) return null;
      try {
        final cleaned = dateStr.replaceAll('Z', '');
        return DateTime.parse(cleaned);
      } catch (_) {
        return null;
      }
    }

    return NotificationPreference(
      id: id,
      userId: userId,
      notificationType: NotificationType.fromJson(notificationType),
      isEnabled: isEnabled,
      deliveryMethod: DeliveryMethod.fromJson(deliveryMethod),
      schedule: schedule?.toDomain(),
      disabledAt: parseDateTime(disabledAt),
    );
  }
}