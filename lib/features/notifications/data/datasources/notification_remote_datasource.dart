import '../../domain/entities/delivery_status.dart';
import '../../domain/entities/notification_type.dart';
import '../models/request/update_preferences_request_dto.dart';
import '../models/response/notification_list_response_dto.dart';
import '../models/response/notification_response_dto.dart';
import '../models/response/preference_list_response_dto.dart';
import '../models/response/unread_count_response_dto.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationListResponseDto> getNotifications({
    DeliveryStatus? status,
    NotificationType? type,
    int page = 1,
    int size = 20,
  });

  Future<NotificationResponseDto> getNotificationById(String notificationId);

  Future<void> markAsRead(String notificationId);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(String notificationId);

  Future<UnreadCountResponseDto> getUnreadCount();

  Future<PreferenceListResponseDto> getPreferences();

  Future<PreferenceListResponseDto> updatePreferences(
    UpdatePreferencesRequestDto request,
  );

  Future<PreferenceListResponseDto> resetPreferences();
}