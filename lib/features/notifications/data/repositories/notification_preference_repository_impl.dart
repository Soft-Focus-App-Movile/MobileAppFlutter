import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/notification_preference.dart';
import '../../domain/repositories/notification_preference_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../models/request/notification_preference_dto.dart';
import '../models/request/notification_schedule_dto.dart';
import '../models/request/update_preferences_request_dto.dart';

class NotificationPreferenceRepositoryImpl implements NotificationPreferenceRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationPreferenceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NotificationPreference>>> getPreferences(
    String userId,
  ) async {
    try {
      final response = await remoteDataSource.getPreferences();

      final preferences = response.preferences?.map((dto) => dto.toDomain()).toList() ?? [];

      return Right(preferences);
    } catch (e) {
      return Left(ServerFailure(
        'Error de red al obtener preferencias: ${e.toString()}',
      ));
    }
  }

  @override
  Future<Either<Failure, NotificationPreference>> updatePreference(
    NotificationPreference preference,
  ) async {
    final result = await updatePreferences([preference]);
    return result.fold(
      (failure) => Left(failure),
      (preferences) => preferences.isNotEmpty
          ? Right(preferences.first)
          : Right(preference),
    );
  }

  @override
  Future<Either<Failure, List<NotificationPreference>>> updatePreferences(
    List<NotificationPreference> preferences,
  ) async {
    try {
      final formatter = DateFormat('HH:mm');

      final preferenceDtos = preferences.map((pref) {
        NotificationScheduleDto? scheduleDto;
        if (pref.schedule != null) {
          final startTime = pref.schedule!.startTime;
          final endTime = pref.schedule!.endTime;

          scheduleDto = NotificationScheduleDto(
            startTime: formatter.format(DateTime(0, 1, 1, startTime.hour, startTime.minute)),
            endTime: formatter.format(DateTime(0, 1, 1, endTime.hour, endTime.minute)),
            daysOfWeek: pref.schedule!.daysOfWeek,
          );
        }

        return NotificationPreferenceDto(
          notificationType: pref.notificationType.toJson().toLowerCase().replaceAll('_', '-'),
          isEnabled: pref.isEnabled,
          schedule: scheduleDto,
          deliveryMethod: pref.deliveryMethod.name.toLowerCase(),
        );
      }).toList();

      final response = await remoteDataSource.updatePreferences(
        UpdatePreferencesRequestDto(preferences: preferenceDtos),
      );

      final updatedPreferences = response.preferences?.map((dto) => dto.toDomain()).toList() ?? [];

      return Right(updatedPreferences);
    } catch (e) {
      return Left(ServerFailure(
        'Error de red al actualizar preferencias: ${e.toString()}',
      ));
    }
  }

  @override
  Future<Either<Failure, List<NotificationPreference>>> resetToDefaults(
    String userId,
  ) async {
    try {
      final response = await remoteDataSource.resetPreferences();

      final preferences = response.preferences?.map((dto) => dto.toDomain()).toList() ?? [];

      return Right(preferences);
    } catch (e) {
      return Left(ServerFailure(
        'Error de red al resetear preferencias: ${e.toString()}',
      ));
    }
  }
}