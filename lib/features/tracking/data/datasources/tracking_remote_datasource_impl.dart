import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/check_in_model.dart';
import '../models/emotional_calendar_model.dart';
import '../models/dashboard_model.dart';
import 'tracking_remote_datasource.dart';

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  final Dio dio;

  TrackingRemoteDataSourceImpl({required this.dio});

  // ============= CHECK-INS =============

  @override
  Future<CreateCheckInApiResponse> createCheckIn(
    CreateCheckInRequest request,
  ) async {
    try {
      final response = await dio.post(
        TrackingEndpoints.checkIns,
        data: request.toJson(),
      );
      return CreateCheckInApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CheckInsHistoryApiResponse> getCheckIns({
    String? startDate,
    String? endDate,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (startDate != null) queryParams['startDate'] = startDate;
      if (endDate != null) queryParams['endDate'] = endDate;
      if (pageNumber != null) queryParams['pageNumber'] = pageNumber;
      if (pageSize != null) queryParams['pageSize'] = pageSize;

      final response = await dio.get(
        TrackingEndpoints.checkIns,
        queryParameters: queryParams,
      );
      return CheckInsHistoryApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CreateCheckInApiResponse> getCheckInById(String id) async {
    try {
      final response = await dio.get(
        TrackingEndpoints.getCheckInById(id),
      );
      return CreateCheckInApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<TodayCheckInApiResponse> getTodayCheckIn() async {
    try {
      final response = await dio.get(TrackingEndpoints.checkInToday);
      return TodayCheckInApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // ============= EMOTIONAL CALENDAR =============

  @override
  Future<CreateEmotionalCalendarApiResponse> createEmotionalCalendarEntry(
    CreateEmotionalCalendarRequest request,
  ) async {
    try {
      final response = await dio.post(
        TrackingEndpoints.emotionalCalendar,
        data: request.toJson(),
      );
      return CreateEmotionalCalendarApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<EmotionalCalendarApiResponse> getEmotionalCalendar({
    String? startDate,
    String? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (startDate != null) queryParams['startDate'] = startDate;
      if (endDate != null) queryParams['endDate'] = endDate;

      final response = await dio.get(
        TrackingEndpoints.emotionalCalendar,
        queryParameters: queryParams,
      );
      return EmotionalCalendarApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CreateEmotionalCalendarApiResponse> getEmotionalCalendarByDate(
    String date,
  ) async {
    try {
      final response = await dio.get(
        TrackingEndpoints.getEmotionalCalendarByDate(date),
      );
      return CreateEmotionalCalendarApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // ============= DASHBOARD =============

  @override
  Future<DashboardApiResponse> getDashboard({int? days}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (days != null) queryParams['days'] = days;

      final response = await dio.get(
        TrackingEndpoints.dashboard,
        queryParameters: queryParams,
      );
      return DashboardApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<DashboardApiResponse> getPatientDashboard({
    required String userId,
    int? days,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (days != null) queryParams['days'] = days;

      final response = await dio.get(
        '${TrackingEndpoints.dashboard}/$userId',
        queryParameters: queryParams,
      );
      return DashboardApiResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // ============= ERROR HANDLING =============

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection timeout. Please try again.');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final message = error.response?.data['message'] ?? 'Server error';
          return Exception('Error $statusCode: $message');
        case DioExceptionType.cancel:
          return Exception('Request was cancelled');
        default:
          return Exception('Network error. Please check your connection.');
      }
    }
    return Exception('An unexpected error occurred');
  }
}