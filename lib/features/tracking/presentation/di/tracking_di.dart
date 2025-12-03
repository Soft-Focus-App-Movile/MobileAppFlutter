import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../auth/data/local/user_session.dart';
import '../../data/datasources/tracking_remote_datasource.dart';
import '../../data/datasources/tracking_remote_datasource_impl.dart';
import '../../data/repositories/tracking_repository_impl.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../../domain/usecases/create_check_in_usecase.dart';
import '../../domain/usecases/get_check_ins_usecase.dart';
import '../../domain/usecases/get_today_check_in_usecase.dart';
import '../../domain/usecases/create_emotional_calendar_entry_usecase.dart';
import '../../domain/usecases/get_emotional_calendar_usecase.dart';
import '../../domain/usecases/get_dashboard_usecase.dart';
import '../providers/tracking_provider.dart';


// ============= DATA SOURCE PROVIDERS =============

final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = ApiConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  
  // Add auth interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Get token from session (you'll need to implement this)
      // For now, we'll add the header if token exists
      final token = await _getAuthToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
  ));
  
  return dio;
});

// Helper function to get auth token
Future<String?> _getAuthToken() async {
  try {
    // Import and use your UserSession here
    final userSession = UserSession();
    final user = await userSession.getUser();
    return user?.token;
  } catch (e) {
    return null;
  }
}

final trackingRemoteDataSourceProvider = Provider<TrackingRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return TrackingRemoteDataSourceImpl(dio: dio);
});

// ============= REPOSITORY PROVIDERS =============

final trackingRepositoryProvider = Provider<TrackingRepository>((ref) {
  final remoteDataSource = ref.watch(trackingRemoteDataSourceProvider);
  return TrackingRepositoryImpl(remoteDataSource: remoteDataSource);
});

// ============= USE CASE PROVIDERS =============

final createCheckInUseCaseProvider = Provider<CreateCheckInUseCase>((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return CreateCheckInUseCase(repository);
});

final getCheckInsUseCaseProvider = Provider<GetCheckInsUseCase>((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetCheckInsUseCase(repository);
});

final getTodayCheckInUseCaseProvider = Provider<GetTodayCheckInUseCase>((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetTodayCheckInUseCase(repository);
});

final createEmotionalCalendarEntryUseCaseProvider = 
    Provider<CreateEmotionalCalendarEntryUseCase>((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return CreateEmotionalCalendarEntryUseCase(repository);
});

final getEmotionalCalendarUseCaseProvider = Provider<GetEmotionalCalendarUseCase>((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetEmotionalCalendarUseCase(repository);
});

final getDashboardUseCaseProvider = Provider<GetDashboardUseCase>((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetDashboardUseCase(repository);
});

// ============= STATE NOTIFIER PROVIDERS =============

final trackingNotifierProvider = StateNotifierProvider<TrackingNotifier, TrackingState>((ref) {
  return TrackingNotifier(
    createCheckInUseCase: ref.watch(createCheckInUseCaseProvider),
    getCheckInsUseCase: ref.watch(getCheckInsUseCaseProvider),
    getTodayCheckInUseCase: ref.watch(getTodayCheckInUseCaseProvider),
    createEmotionalCalendarEntryUseCase: ref.watch(createEmotionalCalendarEntryUseCaseProvider),
    getEmotionalCalendarUseCase: ref.watch(getEmotionalCalendarUseCaseProvider),
    getDashboardUseCase: ref.watch(getDashboardUseCaseProvider),
  );
});

final checkInFormNotifierProvider = 
    StateNotifierProvider<CheckInFormNotifier, CheckInFormState>((ref) {
  return CheckInFormNotifier(
    createCheckInUseCase: ref.watch(createCheckInUseCaseProvider),
  );
});

final emotionalCalendarFormNotifierProvider = 
    StateNotifierProvider<EmotionalCalendarFormNotifier, EmotionalCalendarFormState>((ref) {
  return EmotionalCalendarFormNotifier(
    createEmotionalCalendarEntryUseCase: ref.watch(createEmotionalCalendarEntryUseCaseProvider),
  );
});