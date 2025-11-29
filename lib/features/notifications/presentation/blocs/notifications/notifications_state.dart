import '../../../domain/entities/notification.dart';

class NotificationsState {
  final List<Notification> notifications;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;
  final int unreadCount;
  final bool notificationsEnabled;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
    this.unreadCount = 0,
    this.notificationsEnabled = true,
  });

  NotificationsState copyWith({
    List<Notification>? notifications,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
    int? unreadCount,
    bool? notificationsEnabled,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
      unreadCount: unreadCount ?? this.unreadCount,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}