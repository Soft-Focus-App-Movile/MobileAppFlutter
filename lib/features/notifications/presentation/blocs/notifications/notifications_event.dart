import '../../../domain/entities/delivery_status.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}

class LoadNotifications extends NotificationsEvent {
  const LoadNotifications();
}

class RefreshNotifications extends NotificationsEvent {
  const RefreshNotifications();
}

class FilterNotifications extends NotificationsEvent {
  final DeliveryStatus? status;

  const FilterNotifications(this.status);
}

class MarkNotificationAsRead extends NotificationsEvent {
  final String notificationId;

  const MarkNotificationAsRead(this.notificationId);
}

class MarkAllAsRead extends NotificationsEvent {
  const MarkAllAsRead();
}

class DeleteNotification extends NotificationsEvent {
  final String notificationId;

  const DeleteNotification(this.notificationId);
}

class StartAutoRefresh extends NotificationsEvent {
  const StartAutoRefresh();
}

class StopAutoRefresh extends NotificationsEvent {
  const StopAutoRefresh();
}