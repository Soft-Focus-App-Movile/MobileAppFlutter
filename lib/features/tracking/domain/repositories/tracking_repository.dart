import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/check_in.dart';
import '../entities/emotional_calendar_entry.dart';
import '../entities/dashboard.dart';

abstract class TrackingRepository {
  // ============= CHECK-INS =============

  Future<Either<Failure, CheckIn>> createCheckIn({
    required int emotionalLevel,
    required int energyLevel,
    required String moodDescription,
    required int sleepHours,
    required List<String> symptoms,
    String? notes,
  });

  Future<Either<Failure, CheckInHistory>> getCheckIns({
    String? startDate,
    String? endDate,
    int? pageNumber,
    int? pageSize,
  });

  Future<Either<Failure, CheckIn>> getCheckInById(String id);

  Future<Either<Failure, TodayCheckIn>> getTodayCheckIn();

  // ============= EMOTIONAL CALENDAR =============

  Future<Either<Failure, EmotionalCalendarEntry>> createEmotionalCalendarEntry({
    required String date,
    required String emotionalEmoji,
    required int moodLevel,
    required List<String> emotionalTags,
  });

  Future<Either<Failure, EmotionalCalendar>> getEmotionalCalendar({
    String? startDate,
    String? endDate,
  });

  Future<Either<Failure, EmotionalCalendarEntry>> getEmotionalCalendarByDate(
    String date,
  );

  // ============= DASHBOARD =============

  Future<Either<Failure, TrackingDashboard>> getDashboard({int? days});

  Future<Either<Failure, TrackingDashboard>> getPatientDashboard({
    required String userId,
    int? days,
  });
}