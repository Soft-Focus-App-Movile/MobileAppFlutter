import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_preference.dart';
import '../repositories/notification_preference_repository.dart';

class UpdateNotificationPreferencesUseCase {
  final NotificationPreferenceRepository repository;

  UpdateNotificationPreferencesUseCase(this.repository);

  Future<Either<Failure, List<NotificationPreference>>> call(
    List<NotificationPreference> preferences,
  ) {
    return repository.updatePreferences(preferences);
  }
}