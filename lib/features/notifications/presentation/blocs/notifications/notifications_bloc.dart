import 'dart:async';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/session_manager.dart';
import '../../../../auth/domain/models/user_type.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/entities/delivery_status.dart';
import '../../../domain/entities/notification_type.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/repositories/notification_repository.dart';
import '../../../domain/usecases/get_notifications_usecase.dart';
import '../../../domain/usecases/get_notification_preferences_usecase.dart';
import '../../../domain/usecases/mark_as_read_usecase.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final GetNotificationPreferencesUseCase getPreferencesUseCase;
  final NotificationRepository notificationRepository;
  final SessionManager sessionManager;
  
  DeliveryStatus? _currentFilter;
  List<Notification> _allNotifications = [];
  Timer? _autoRefreshTimer;

  NotificationsBloc({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.getPreferencesUseCase,
    required this.notificationRepository,
    required this.sessionManager,
  }) : super(const NotificationsState()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<RefreshNotifications>(_onRefreshNotifications);
    on<FilterNotifications>(_onFilterNotifications);
    on<MarkNotificationAsRead>(_onMarkAsRead);
    on<MarkAllAsRead>(_onMarkAllAsRead);
    on<DeleteNotification>(_onDeleteNotification);
    on<StartAutoRefresh>(_onStartAutoRefresh);
    on<StopAutoRefresh>(_onStopAutoRefresh);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = await sessionManager.getCurrentUser();
      if (user == null) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Usuario no autenticado',
        ));
        return;
      }

      final preferencesResult = await getPreferencesUseCase(user.id);
      final masterPreference = preferencesResult.fold(
        (failure) => null,
        (preferences) => preferences.isNotEmpty ? preferences.first : null,
      );

      final notificationsEnabled = masterPreference?.isEnabled ?? true;
      final schedule = masterPreference?.schedule;
      final disabledAt = masterPreference?.disabledAt;

      final result = await getNotificationsUseCase(userId: user.id, status: null);

      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message ?? 'Error al cargar notificaciones',
          ));
        },
        (notifications) {
          _allNotifications = notifications;

          if (!notificationsEnabled && disabledAt != null) {
            _allNotifications = notifications
                .where((n) =>
                    n.createdAt.isBefore(disabledAt) ||
                    n.createdAt.isAtSameMomentAs(disabledAt))
                .toList();
          }

          emit(state.copyWith(
            notificationsEnabled: notificationsEnabled,
            isLoading: false,
          ));

          _applyFilter(user.userType, notificationsEnabled, schedule, emit);
          _loadUnreadCount(user.id, emit);
        },
      );
    } catch (e, stackTrace) {
      print('❌ Error en _onLoadNotifications: $e');
      print('StackTrace: $stackTrace');
      emit(state.copyWith(
        isLoading: false,
        error: 'Error inesperado: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRefreshNotifications(
    RefreshNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      emit(state.copyWith(isRefreshing: true, error: null));

      final user = await sessionManager.getCurrentUser();
      if (user == null) {
        emit(state.copyWith(isRefreshing: false));
        return;
      }

      final preferencesResult = await getPreferencesUseCase(user.id);
      final masterPreference = preferencesResult.fold(
        (failure) => null,
        (preferences) => preferences.isNotEmpty ? preferences.first : null,
      );

      final notificationsEnabled = masterPreference?.isEnabled ?? true;
      final schedule = masterPreference?.schedule;
      final disabledAt = masterPreference?.disabledAt;

      final result = await notificationRepository.getNotifications(
        userId: user.id,
        status: null,
        page: 1,
        size: 20,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            isRefreshing: false,
            error: failure.message ?? 'Error al actualizar',
          ));
        },
        (notifications) {
          _allNotifications = notifications;

          if (!notificationsEnabled && disabledAt != null) {
            _allNotifications = notifications
                .where((n) =>
                    n.createdAt.isBefore(disabledAt) ||
                    n.createdAt.isAtSameMomentAs(disabledAt))
                .toList();
          }

          emit(state.copyWith(
            notificationsEnabled: notificationsEnabled,
            isRefreshing: false,
          ));

          _applyFilter(user.userType, notificationsEnabled, schedule, emit);
          _loadUnreadCount(user.id, emit);
        },
      );
    } catch (e) {
      print('❌ Error en _onRefreshNotifications: $e');
      emit(state.copyWith(
        isRefreshing: false,
        error: 'Error al actualizar',
      ));
    }
  }

  Future<void> _onFilterNotifications(
    FilterNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    // ✅ CORREGIDO: Todo debe estar dentro del async
    try {
      _currentFilter = event.status;

      final user = await sessionManager.getCurrentUser();
      if (user == null) return;

      final preferencesResult = await getPreferencesUseCase(user.id);
      final schedule = preferencesResult.fold(
        (failure) => null,
        (preferences) => preferences.isNotEmpty ? preferences.first.schedule : null,
      );

      // ✅ Verificar que el emitter no esté completo antes de emitir
      if (!emit.isDone) {
        _applyFilter(user.userType, state.notificationsEnabled, schedule, emit);
      }
    } catch (e) {
      print('❌ Error en _onFilterNotifications: $e');
    }
  }

  void _applyFilter(
    UserType? userType,
    bool notificationsEnabled,
    dynamic schedule,
    Emitter<NotificationsState> emit,
  ) {
    // ✅ Verificar que el emitter no esté completo
    if (emit.isDone) return;

    var filtered = _currentFilter == DeliveryStatus.delivered
        ? _allNotifications.where((n) => n.readAt == null).toList()
        : _allNotifications;

    if (notificationsEnabled && userType == UserType.PSYCHOLOGIST && schedule != null) {
      final now = TimeOfDay.now();
      final isWithinSchedule = schedule.isWithinSchedule(now);

      if (!isWithinSchedule) {
        filtered = filtered.where((notification) {
          final wasAlreadyRead = notification.readAt != null;
          final isCritical = notification.type == NotificationType.crisisAlert ||
              notification.type == NotificationType.emergency ||
              notification.priority == Priority.critical ||
              notification.priority == Priority.high;

          return wasAlreadyRead || isCritical;
        }).toList();
      }
    }

    emit(state.copyWith(notifications: filtered));
  }

  Future<void> _onMarkAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationsState> emit,
  ) async {
    // ✅ CORREGIDO: Ahora todo es await, no .then()
    try {
      final result = await markAsReadUseCase(event.notificationId);

      result.fold(
        (failure) {
          print('❌ Error al marcar como leída: ${failure.message}');
        },
        (_) async {
          // ✅ Actualizar lista local
          _allNotifications = _allNotifications.map((notification) {
            if (notification.id == event.notificationId) {
              return notification.copyWith(
                status: DeliveryStatus.read,
                readAt: DateTime.now(),
              );
            }
            return notification;
          }).toList();

          // ✅ AWAIT en lugar de .then()
          final user = await sessionManager.getCurrentUser();
          if (user != null && !emit.isDone) {
            final preferencesResult = await getPreferencesUseCase(user.id);
            final schedule = preferencesResult.fold(
              (failure) => null,
              (preferences) => preferences.isNotEmpty ? preferences.first.schedule : null,
            );
            
            _applyFilter(user.userType, state.notificationsEnabled, schedule, emit);
            await _loadUnreadCount(user.id, emit);
          }
        },
      );
    } catch (e) {
      print('❌ Error en _onMarkAsRead: $e');
    }
  }

  Future<void> _onMarkAllAsRead(
    MarkAllAsRead event,
    Emitter<NotificationsState> emit,
  ) async {
    // ✅ CORREGIDO: Ahora todo es await
    try {
      final user = await sessionManager.getCurrentUser();
      if (user == null) return;

      final result = await notificationRepository.markAllAsRead(user.id);

      result.fold(
        (failure) {
          print('❌ Error al marcar todas como leídas: ${failure.message}');
        },
        (_) async {
          // ✅ Actualizar lista local
          _allNotifications = _allNotifications.map((notification) {
            return notification.copyWith(
              status: DeliveryStatus.read,
              readAt: notification.readAt ?? DateTime.now(),
            );
          }).toList();

          // ✅ AWAIT en lugar de .then()
          if (!emit.isDone) {
            final preferencesResult = await getPreferencesUseCase(user.id);
            final schedule = preferencesResult.fold(
              (failure) => null,
              (preferences) => preferences.isNotEmpty ? preferences.first.schedule : null,
            );
            
            _applyFilter(user.userType, state.notificationsEnabled, schedule, emit);
            await _loadUnreadCount(user.id, emit);
          }
        },
      );
    } catch (e) {
      print('❌ Error en _onMarkAllAsRead: $e');
    }
  }

  Future<void> _onDeleteNotification(
    DeleteNotification event,
    Emitter<NotificationsState> emit,
  ) async {
    // ✅ CORREGIDO: Ahora todo es await
    try {
      final user = await sessionManager.getCurrentUser();
      if (user == null) return;

      final result = await notificationRepository.deleteNotification(event.notificationId);

      result.fold(
        (failure) {
          print('❌ Error al eliminar notificación: ${failure.message}');
        },
        (_) async {
          // ✅ Actualizar lista local
          _allNotifications = _allNotifications
              .where((n) => n.id != event.notificationId)
              .toList();

          // ✅ AWAIT en lugar de .then()
          if (!emit.isDone) {
            final preferencesResult = await getPreferencesUseCase(user.id);
            final schedule = preferencesResult.fold(
              (failure) => null,
              (preferences) => preferences.isNotEmpty ? preferences.first.schedule : null,
            );
            
            _applyFilter(user.userType, state.notificationsEnabled, schedule, emit);
            await _loadUnreadCount(user.id, emit);
          }
        },
      );
    } catch (e) {
      print('❌ Error en _onDeleteNotification: $e');
    }
  }

  Future<void> _loadUnreadCount(String userId, Emitter<NotificationsState> emit) async {
    // ✅ Verificar que el emitter no esté completo
    if (emit.isDone) return;

    final result = await notificationRepository.getUnreadCount(userId);

    result.fold(
      (failure) {
        print('❌ Error al cargar contador: ${failure.message}');
      },
      (count) {
        if (!emit.isDone) {
          final finalCount = state.notificationsEnabled ? count : 0;
          emit(state.copyWith(unreadCount: finalCount));
        }
      },
    );
  }

  void _onStartAutoRefresh(
    StartAutoRefresh event,
    Emitter<NotificationsState> emit,
  ) {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => add(const RefreshNotifications()),
    );
  }

  void _onStopAutoRefresh(
    StopAutoRefresh event,
    Emitter<NotificationsState> emit,
  ) {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = null;
  }

  @override
  Future<void> close() {
    _autoRefreshTimer?.cancel();
    return super.close();
  }
}