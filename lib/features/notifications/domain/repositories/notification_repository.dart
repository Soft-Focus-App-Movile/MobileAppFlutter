import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification.dart';
import '../entities/notification_type.dart';
import '../entities/delivery_status.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications({
    required String userId,
    DeliveryStatus? status,
    NotificationType? type,
    int page = 1,
    int size = 20,
  });

  Future<Either<Failure, Notification>> getNotificationById(String id);

  Future<Either<Failure, void>> markAsRead(String notificationId);

  Future<Either<Failure, void>> markAllAsRead(String userId);

  Future<Either<Failure, void>> deleteNotification(String notificationId);

  Future<Either<Failure, int>> getUnreadCount(String userId);

  Stream<List<Notification>> observeNotifications(String userId);
}