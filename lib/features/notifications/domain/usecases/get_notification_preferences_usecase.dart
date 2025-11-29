import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_preference.dart';
import '../repositories/notification_preference_repository.dart';

class GetNotificationPreferencesUseCase {
  final NotificationPreferenceRepository repository;

  GetNotificationPreferencesUseCase(this.repository);

  Future<Either<Failure, List<NotificationPreference>>> call(String userId) {
    return repository.getPreferences(userId);
  }
}