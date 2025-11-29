import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification.dart';
import '../entities/delivery_status.dart';
import '../entities/notification_type.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<Either<Failure, List<Notification>>> call({
    required String userId,
    DeliveryStatus? status,
    NotificationType? type,
    int page = 1,
  }) {
    return repository.getNotifications(
      userId: userId,
      status: status,
      type: type,
      page: page,
    );
  }
}