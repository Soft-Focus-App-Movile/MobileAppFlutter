import 'package:dio/dio.dart';
import '../../domain/entities/delivery_status.dart';
import '../../domain/entities/notification_type.dart';
import '../models/request/update_preferences_request_dto.dart';
import '../models/response/notification_list_response_dto.dart';
import '../models/response/notification_response_dto.dart';
import '../models/response/preference_list_response_dto.dart';
import '../models/response/unread_count_response_dto.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio httpClient;

  NotificationRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<NotificationListResponseDto> getNotifications({
    DeliveryStatus? status,
    NotificationType? type,
    int page = 1,
    int size = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page > 0 ? page : 1,
      'size': size > 0 ? size : 20,
    };

    if (status != null) {
      queryParams['status'] = status.name.toLowerCase();
    }

    if (type != null) {
      queryParams['type'] = type.name.toLowerCase();
    }

    final response = await httpClient.get(
      '/notifications',
      queryParameters: queryParams,
    );

    return NotificationListResponseDto.fromJson(response.data);
  }

  @override
  Future<NotificationResponseDto> getNotificationById(String notificationId) async {
    final response = await httpClient.get('/notifications/detail/$notificationId');
    return NotificationResponseDto.fromJson(response.data);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await httpClient.post('/notifications/$notificationId/read');
  }

  @override
  Future<void> markAllAsRead() async {
    await httpClient.post('/notifications/read-all');
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await httpClient.delete('/notifications/$notificationId');
  }

  @override
  Future<UnreadCountResponseDto> getUnreadCount() async {
    final response = await httpClient.get('/notifications/unread-count');
    return UnreadCountResponseDto.fromJson(response.data);
  }

  @override
  Future<PreferenceListResponseDto> getPreferences() async {
    final response = await httpClient.get('/preferences');
    return PreferenceListResponseDto.fromJson(response.data);
  }

  @override
  Future<PreferenceListResponseDto> updatePreferences(
    UpdatePreferencesRequestDto request,
  ) async {
    final response = await httpClient.put(
      '/preferences',
      data: request.toJson(),
    );
    return PreferenceListResponseDto.fromJson(response.data);
  }

  @override
  Future<PreferenceListResponseDto> resetPreferences() async {
    final response = await httpClient.post('/preferences/reset');
    return PreferenceListResponseDto.fromJson(response.data);
  }
}