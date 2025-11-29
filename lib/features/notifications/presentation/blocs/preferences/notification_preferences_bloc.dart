import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/session_manager.dart';
import '../../../domain/entities/notification_preference.dart';
import '../../../domain/entities/notification_schedule.dart';
import '../../../domain/entities/notification_type.dart';
import '../../../domain/entities/delivery_method.dart';
import '../../../domain/usecases/get_notification_preferences_usecase.dart';
import '../../../domain/usecases/update_notification_preferences_usecase.dart';
import 'notification_preferences_event.dart';
import 'notification_preferences_state.dart';

class NotificationPreferencesBloc
    extends Bloc<NotificationPreferencesEvent, NotificationPreferencesState> {
  final GetNotificationPreferencesUseCase getPreferencesUseCase;
  final UpdateNotificationPreferencesUseCase updatePreferencesUseCase;

  NotificationPreferencesBloc({
    required this.getPreferencesUseCase,
    required this.updatePreferencesUseCase,
  }) : super(const NotificationPreferencesState()) {
    on<LoadPreferences>(_onLoadPreferences);
    on<ToggleMasterPreference>(_onToggleMasterPreference);
    on<UpdateSchedule>(_onUpdateSchedule);

    // Cargar preferencias al iniciar
    add(const LoadPreferences());
  }

  Future<void> _onLoadPreferences(
    LoadPreferences event,
    Emitter<NotificationPreferencesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = await SessionManager.getCurrentUser();
      if (user == null) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Usuario no autenticado',
        ));
        return;
      }

      final result = await getPreferencesUseCase(user.id);

      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message ?? 'Error al cargar preferencias',
          ));
        },
        (preferences) {
          final enrichedPreferences = _ensureMainPreferences(preferences, user.id);
          emit(state.copyWith(
            preferences: enrichedPreferences,
            isLoading: false,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar: ${e.toString()}',
      ));
    }
  }

  Future<void> _onToggleMasterPreference(
    ToggleMasterPreference event,
    Emitter<NotificationPreferencesState> emit,
  ) async {
    try {
      emit(state.copyWith(isSaving: true, successMessage: null, error: null));

      if (state.preferences.isEmpty) {
        emit(state.copyWith(
          isSaving: false,
          error: 'No hay preferencias configuradas',
        ));
        return;
      }

      final masterPreference = state.preferences.first;
      final newEnabled = !masterPreference.isEnabled;
      final updated = masterPreference.copyWith(isEnabled: newEnabled);
      final updatedList = [updated];

      final result = await updatePreferencesUseCase(updatedList);

      result.fold(
        (failure) {
          emit(state.copyWith(
            isSaving: false,
            error: failure.message ?? 'Error al actualizar',
          ));
        },
        (serverPreferences) {
          final finalPreferences = serverPreferences.isNotEmpty
              ? serverPreferences
              : updatedList;

          emit(state.copyWith(
            preferences: finalPreferences,
            isSaving: false,
            successMessage: newEnabled
                ? 'Notificaciones activadas'
                : 'Notificaciones desactivadas',
          ));

          // Limpiar mensaje de éxito después de 3 segundos
          Future.delayed(const Duration(seconds: 3), () {
            if (!emit.isDone) {
              emit(state.copyWith(successMessage: null));
            }
          });
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        error: 'Error inesperado: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateSchedule(
    UpdateSchedule event,
    Emitter<NotificationPreferencesState> emit,
  ) async {
    try {
      emit(state.copyWith(isSaving: true, successMessage: null, error: null));

      if (state.preferences.isEmpty) {
        emit(state.copyWith(
          isSaving: false,
          error: 'No hay preferencias configuradas',
        ));
        return;
      }

      final masterPreference = state.preferences.first;

      final newSchedule = NotificationSchedule(
        startTime: event.startTime,
        endTime: event.endTime,
        daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
      );

      final updated = masterPreference.copyWith(schedule: newSchedule);
      final updatedList = [updated];

      final result = await updatePreferencesUseCase(updatedList);

      result.fold(
        (failure) {
          emit(state.copyWith(
            isSaving: false,
            error: failure.message ?? 'Error al actualizar horario',
          ));
        },
        (serverPreferences) {
          final finalPreferences = serverPreferences.isNotEmpty
              ? serverPreferences
              : updatedList;

          emit(state.copyWith(
            preferences: finalPreferences,
            isSaving: false,
            successMessage: 'Horario actualizado correctamente',
          ));

          // Limpiar mensaje de éxito después de 3 segundos
          Future.delayed(const Duration(seconds: 3), () {
            if (!emit.isDone) {
              emit(state.copyWith(successMessage: null));
            }
          });
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        error: 'Error inesperado: ${e.toString()}',
      ));
    }
  }

  List<NotificationPreference> _ensureMainPreferences(
    List<NotificationPreference> preferences,
    String userId,
  ) {
    try {
      final mainTypes = [
        NotificationType.checkinReminder,
        NotificationType.info,
        NotificationType.systemUpdate,
      ];

      final filteredPrefs = preferences
          .where((pref) => mainTypes.contains(pref.notificationType))
          .toList();

      final mutablePrefs = <NotificationPreference>[];

      // Check-in reminder preference
      final checkInPref = filteredPrefs.firstWhere(
        (p) => p.notificationType == NotificationType.checkinReminder,
        orElse: () => NotificationPreference(
          id: 'checkin_reminder_local',
          userId: userId,
          notificationType: NotificationType.checkinReminder,
          isEnabled: true,
          deliveryMethod: DeliveryMethod.push,
          schedule: NotificationSchedule(
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 9, minute: 0),
            daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
          ),
        ),
      );

      final prefWithSchedule = checkInPref.schedule == null
          ? checkInPref.copyWith(
              schedule: NotificationSchedule(
                startTime: const TimeOfDay(hour: 9, minute: 0),
                endTime: const TimeOfDay(hour: 9, minute: 0),
                daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
              ),
            )
          : checkInPref;

      mutablePrefs.add(prefWithSchedule);

      // Info preference
      final infoPref = filteredPrefs.firstWhere(
        (p) => p.notificationType == NotificationType.info,
        orElse: () => NotificationPreference(
          id: 'daily_suggestions_local',
          userId: userId,
          notificationType: NotificationType.info,
          isEnabled: true,
          deliveryMethod: DeliveryMethod.push,
        ),
      );
      mutablePrefs.add(infoPref);

      // System update preference
      final systemPref = filteredPrefs.firstWhere(
        (p) => p.notificationType == NotificationType.systemUpdate,
        orElse: () => NotificationPreference(
          id: 'promotions_local',
          userId: userId,
          notificationType: NotificationType.systemUpdate,
          isEnabled: true,
          deliveryMethod: DeliveryMethod.push,
        ),
      );
      mutablePrefs.add(systemPref);

      // Ordenar por prioridad
      mutablePrefs.sort((a, b) {
        final typeOrder = {
          NotificationType.checkinReminder: 1,
          NotificationType.info: 2,
          NotificationType.systemUpdate: 3,
        };
        return (typeOrder[a.notificationType] ?? 4)
            .compareTo(typeOrder[b.notificationType] ?? 4);
      });

      return mutablePrefs;
    } catch (e) {
      return [];
    }
  }
}