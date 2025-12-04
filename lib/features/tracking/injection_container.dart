import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../features/auth/data/local/user_session.dart';
import 'data/datasources/tracking_remote_datasource.dart';
import 'data/datasources/tracking_remote_datasource_impl.dart';
import 'data/repositories/tracking_repository_impl.dart';
import 'domain/repositories/tracking_repository.dart';
import 'domain/usecases/create_check_in_usecase.dart';
import 'domain/usecases/get_check_ins_usecase.dart';
import 'domain/usecases/get_today_check_in_usecase.dart';
import 'domain/usecases/create_emotional_calendar_entry_usecase.dart';
import 'domain/usecases/get_emotional_calendar_usecase.dart';
import 'domain/usecases/get_dashboard_usecase.dart';
import 'presentation/bloc/tracking_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ============= BLOC =============
  
  sl.registerFactory(
    () => TrackingBloc(
      createCheckInUseCase: sl(),
      getCheckInsUseCase: sl(),
      getTodayCheckInUseCase: sl(),
      createEmotionalCalendarEntryUseCase: sl(),
      getEmotionalCalendarUseCase: sl(),
      getDashboardUseCase: sl(),
    ),
  );

  // ============= USE CASES =============

  sl.registerLazySingleton(() => CreateCheckInUseCase(sl()));
  sl.registerLazySingleton(() => GetCheckInsUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayCheckInUseCase(sl()));
  sl.registerLazySingleton(() => CreateEmotionalCalendarEntryUseCase(sl()));
  sl.registerLazySingleton(() => GetEmotionalCalendarUseCase(sl()));
  sl.registerLazySingleton(() => GetDashboardUseCase(sl()));

  // ============= REPOSITORIES =============

  sl.registerLazySingleton<TrackingRepository>(
    () => TrackingRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // ============= DATA SOURCES =============

  sl.registerLazySingleton<TrackingRemoteDataSource>(
    () => TrackingRemoteDataSourceImpl(
      dio: sl(),
    ),
  );

  // ============= EXTERNAL =============

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );

    // Add auth interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Agregar token de autenticación
          try {
            final userSession = UserSession();
            final user = await userSession.getUser();
            final isExpired = await userSession.isTokenExpired();
            
            if (user != null && !isExpired) {
              options.headers['Authorization'] = 'Bearer ${user.token}';
            }
          } catch (e) {
            // Si hay error obteniendo el token, continuar sin él
            print('Error obteniendo token: $e');
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Manejar errores 401 (token expirado)
          if (error.response?.statusCode == 401) {
            print('Token expirado o no válido - error 401');
            // Opcional: limpiar sesión si el token no es válido
            try {
              final userSession = UserSession();
              await userSession.clear();
            } catch (e) {
              print('Error limpiando sesión: $e');
            }
          }
          handler.next(error);
        },
      ),
    );

    return dio;
  });
}