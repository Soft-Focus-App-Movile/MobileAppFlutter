import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_preference.dart';

abstract class NotificationPreferenceRepository {
  Future<Either<Failure, List<NotificationPreference>>> getPreferences(String userId);

  Future<Either<Failure, NotificationPreference>> updatePreference(
    NotificationPreference preference,
  );

  Future<Either<Failure, List<NotificationPreference>>> updatePreferences(
    List<NotificationPreference> preferences,
  );

  Future<Either<Failure, List<NotificationPreference>>> resetToDefaults(String userId);
}