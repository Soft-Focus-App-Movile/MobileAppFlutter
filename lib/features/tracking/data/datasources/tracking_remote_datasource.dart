import '../models/check_in_model.dart';
import '../models/emotional_calendar_model.dart';
import '../models/dashboard_model.dart';

abstract class TrackingRemoteDataSource {
  // ============= CHECK-INS =============
  
  Future<CreateCheckInApiResponse> createCheckIn(
    CreateCheckInRequest request,
  );

  Future<CheckInsHistoryApiResponse> getCheckIns({
    String? startDate,
    String? endDate,
    int? pageNumber,
    int? pageSize,
  });

  Future<CreateCheckInApiResponse> getCheckInById(String id);

  Future<TodayCheckInApiResponse> getTodayCheckIn();

  // ============= EMOTIONAL CALENDAR =============

  Future<CreateEmotionalCalendarApiResponse> createEmotionalCalendarEntry(
    CreateEmotionalCalendarRequest request,
  );

  Future<EmotionalCalendarApiResponse> getEmotionalCalendar({
    String? startDate,
    String? endDate,
  });

  Future<CreateEmotionalCalendarApiResponse> getEmotionalCalendarByDate(
    String date,
  );

  // ============= DASHBOARD =============

  Future<DashboardApiResponse> getDashboard({int? days});

  Future<DashboardApiResponse> getPatientDashboard({
    required String userId,
    int? days,
  });
}