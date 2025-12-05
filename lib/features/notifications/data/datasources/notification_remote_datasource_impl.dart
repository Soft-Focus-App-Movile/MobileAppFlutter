import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../domain/entities/delivery_status.dart';
import '../../domain/entities/notification_type.dart';
import '../models/request/update_preferences_request_dto.dart';
import '../models/response/notification_list_response_dto.dart';
import '../models/response/notification_response_dto.dart';
import '../models/response/preference_list_response_dto.dart';
import '../models/response/unread_count_response_dto.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final HttpClient httpClient;

  NotificationRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<NotificationListResponseDto> getNotifications({
    DeliveryStatus? status,
    NotificationType? type,
    int page = 1,
    int size = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': (page > 0 ? page : 1).toString(),
      'size': (size > 0 ? size : 20).toString(),
    };

    if (status != null) {
      queryParams['status'] = status.name.toLowerCase();
    }

    if (type != null) {
      queryParams['type'] = type.name.toLowerCase();
    }

    final response = await httpClient.get(
      'notifications',
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return NotificationListResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  @override
  Future<NotificationResponseDto> getNotificationById(String notificationId) async {
    final response = await httpClient.get('notifications/detail/$notificationId');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return NotificationResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Notificación no encontrada');
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final response = await httpClient.post('notifications/$notificationId/read');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al marcar como leída');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    final response = await httpClient.post('notifications/read-all');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al marcar todas como leídas');
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final response = await httpClient.delete('notifications/$notificationId');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar notificación');
    }
  }

  @override
  Future<UnreadCountResponseDto> getUnreadCount() async {
    final response = await httpClient.get('notifications/unread-count');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UnreadCountResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Error al obtener contador');
    }
  }

  @override
  Future<PreferenceListResponseDto> getPreferences() async {
    final response = await httpClient.get('preferences');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PreferenceListResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Error al obtener preferencias');
    }
  }

  @override
  Future<PreferenceListResponseDto> updatePreferences(
    UpdatePreferencesRequestDto request,
  ) async {
    final response = await httpClient.put(
      'preferences',
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PreferenceListResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Error al actualizar preferencias');
    }
  }

  @override
  Future<PreferenceListResponseDto> resetPreferences() async {
    final response = await httpClient.post('preferences/reset');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PreferenceListResponseDto.fromJson(jsonData);
    } else {
      throw Exception('Error al resetear preferencias');
    }
  }
}