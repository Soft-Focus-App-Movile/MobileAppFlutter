import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/data/local/local_user_data_source.dart';
import '../../domain/entities/notification.dart';
import '../../domain/entities/notification_type.dart';
import '../../domain/entities/delivery_status.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final LocalUserDataSource localUserDataSource; // CORREGIDO

  NotificationRepositoryImpl({
    required this.remoteDataSource,
    required this.localUserDataSource, // CORREGIDO
  });

  @override
  Future<Either<Failure, List<Notification>>> getNotifications({
    required String userId,
    DeliveryStatus? status,
    NotificationType? type,
    int page = 1,
    int size = 20,
  }) async {
    try {
      final validPage = page > 0 ? page : 1;
      final validSize = size > 0 ? size : 20;

      final response = await remoteDataSource.getNotifications(
        status: status,
        type: type,
        page: validPage,
        size: validSize,
      );

      final notifications = response.notifications.map((dto) => dto.toDomain()).toList();

      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure('Error de conexión: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Notification>> getNotificationById(String id) async {
    try {
      final response = await remoteDataSource.getNotificationById(id);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ServerFailure('Notificación no encontrada'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    try {
      await remoteDataSource.markAsRead(notificationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al marcar como leída'));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead(String userId) async {
    try {
      await remoteDataSource.markAllAsRead();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al marcar todas como leídas'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String notificationId) async {
    try {
      await remoteDataSource.deleteNotification(notificationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al eliminar notificación'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String userId) async {
    try {
      final response = await remoteDataSource.getUnreadCount();
      return Right(response.unreadCount);
    } catch (e) {
      return Left(ServerFailure('Error al obtener contador'));
    }
  }

  @override
  Stream<List<Notification>> observeNotifications(String userId) {
    // Implementación básica - puedes mejorarla con WebSockets o polling
    return Stream.value([]);
  }
}