import 'package:flutter_app_softfocus/core/utils/session_manager.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/notification_remote_datasource.dart';
import 'data/datasources/notification_remote_datasource_impl.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'data/repositories/notification_preference_repository_impl.dart';
import 'domain/repositories/notification_repository.dart';
import 'domain/repositories/notification_preference_repository.dart';
import 'domain/usecases/get_notifications_usecase.dart';
import 'domain/usecases/get_notification_preferences_usecase.dart';
import 'domain/usecases/mark_as_read_usecase.dart';
import 'domain/usecases/update_notification_preferences_usecase.dart';
import 'presentation/blocs/notifications/notifications_bloc.dart';
import 'presentation/blocs/preferences/notification_preferences_bloc.dart';
import '../../core/networking/http_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print('🔧 Inicializando módulo de Notificaciones...');
  
  // ========== DATA SOURCES ==========
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () {
      print('🔧 Creando NotificationRemoteDataSource...');
      return NotificationRemoteDataSourceImpl(
        httpClient: sl<HttpClient>(),
      );
    },
  );

  // ========== REPOSITORIES ==========
  sl.registerLazySingleton<NotificationRepository>(
    () {
      print('🔧 Creando NotificationRepository...');
      return NotificationRepositoryImpl(
        remoteDataSource: sl(),
        localUserDataSource: sl(),
      );
    },
  );

  sl.registerLazySingleton<NotificationPreferenceRepository>(
    () {
      print('🔧 Creando NotificationPreferenceRepository...');
      return NotificationPreferenceRepositoryImpl(
        remoteDataSource: sl(),
      );
    },
  );

  // ========== USE CASES ==========
  sl.registerLazySingleton(() {
    print('🔧 Creando GetNotificationsUseCase...');
    return GetNotificationsUseCase(sl());
  });
  
  sl.registerLazySingleton(() {
    print('🔧 Creando GetNotificationPreferencesUseCase...');
    return GetNotificationPreferencesUseCase(sl());
  });
  
  sl.registerLazySingleton(() {
    print('🔧 Creando MarkAsReadUseCase...');
    return MarkAsReadUseCase(sl());
  });
  
  sl.registerLazySingleton(() {
    print('🔧 Creando UpdateNotificationPreferencesUseCase...');
    return UpdateNotificationPreferencesUseCase(sl());
  });

  // ========== BLOCS ==========
  sl.registerFactory(
    () {
      print('🔧 Creando NotificationsBloc...');
      return NotificationsBloc(
        getNotificationsUseCase: sl(),
        markAsReadUseCase: sl(),
        getPreferencesUseCase: sl(),
        notificationRepository: sl(),
        sessionManager: SessionManager.instance,
      );
    },
  );

  sl.registerFactory(
    () {
      print('🔧 Creando NotificationPreferencesBloc...');
      return NotificationPreferencesBloc(
        getPreferencesUseCase: sl(),
        updatePreferencesUseCase: sl(),
        sessionManager: SessionManager.instance,
      );
    },
  );
}