import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/check_in.dart';
import '../../domain/entities/emotional_calendar_entry.dart';
import '../../domain/entities/dashboard.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../datasources/tracking_remote_datasource.dart';
import '../models/check_in_model.dart';
import '../models/emotional_calendar_model.dart';
import '../mappers/tracking_mapper.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingRemoteDataSource remoteDataSource;

  TrackingRepositoryImpl({required this.remoteDataSource});

  // ============= CHECK-INS =============

  @override
  Future<Either<Failure, CheckIn>> createCheckIn({
    required int emotionalLevel,
    required int energyLevel,
    required String moodDescription,
    required int sleepHours,
    required List<String> symptoms,
    String? notes,
  }) async {
    try {
      final request = CreateCheckInRequest(
        emotionalLevel: emotionalLevel,
        energyLevel: energyLevel,
        moodDescription: moodDescription,
        sleepHours: sleepHours,
        symptoms: symptoms,
        notes: notes,
      );

      final response = await remoteDataSource.createCheckIn(request);
      return Right(response.data.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckInHistory>> getCheckIns({
    String? startDate,
    String? endDate,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await remoteDataSource.getCheckIns(
        startDate: startDate,
        endDate: endDate,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return Right(response.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckIn>> getCheckInById(String id) async {
    try {
      final response = await remoteDataSource.getCheckInById(id);
      return Right(response.data.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TodayCheckIn>> getTodayCheckIn() async {
    try {
      final response = await remoteDataSource.getTodayCheckIn();
      return Right(response.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ============= EMOTIONAL CALENDAR =============

  @override
  Future<Either<Failure, EmotionalCalendarEntry>> createEmotionalCalendarEntry({
    required String date,
    required String emotionalEmoji,
    required int moodLevel,
    required List<String> emotionalTags,
  }) async {
    try {
      final request = CreateEmotionalCalendarRequest(
        date: date,
        emotionalEmoji: emotionalEmoji,
        moodLevel: moodLevel,
        emotionalTags: emotionalTags,
      );

      final response = await remoteDataSource.createEmotionalCalendarEntry(request);
      return Right(response.data.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EmotionalCalendar>> getEmotionalCalendar({
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await remoteDataSource.getEmotionalCalendar(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(response.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EmotionalCalendarEntry>> getEmotionalCalendarByDate(
    String date,
  ) async {
    try {
      final response = await remoteDataSource.getEmotionalCalendarByDate(date);
      return Right(response.data.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ============= DASHBOARD =============

  @override
  Future<Either<Failure, TrackingDashboard>> getDashboard({int? days}) async {
    try {
      final response = await remoteDataSource.getDashboard(days: days);
      return Right(response.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrackingDashboard>> getPatientDashboard({
    required String userId,
    int? days,
  }) async {
    try {
      final response = await remoteDataSource.getPatientDashboard(
        userId: userId,
        days: days,
      );
      return Right(response.toDomain());
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ============= ERROR HANDLING =============

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout. Please try again.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'Server error';
        
        if (statusCode == 401) {
          return ServerFailure('Unauthorized. Please login again.');
        } else if (statusCode == 403) {
          return ServerFailure('Access forbidden.');
        } else if (statusCode == 404) {
          return ServerFailure('Resource not found.');
        } else if (statusCode == 409) {
          return ServerFailure(message); // Conflict - ya existe entrada
        } else {
          return ServerFailure('Error $statusCode: $message');
        }

      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No internet connection. Please check your network.',
        );

      default:
        return const NetworkFailure('Network error. Please try again.');
    }
  }
}