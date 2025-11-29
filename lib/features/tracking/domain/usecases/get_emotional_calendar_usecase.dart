import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/emotional_calendar_entry.dart';
import '../repositories/tracking_repository.dart';

class GetEmotionalCalendarUseCase
    implements UseCase<EmotionalCalendar, GetEmotionalCalendarParams> {
  final TrackingRepository repository;

  GetEmotionalCalendarUseCase(this.repository);

  @override
  Future<Either<Failure, EmotionalCalendar>> call(
    GetEmotionalCalendarParams params,
  ) async {
    return await repository.getEmotionalCalendar(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetEmotionalCalendarParams {
  final String? startDate;
  final String? endDate;

  GetEmotionalCalendarParams({
    this.startDate,
    this.endDate,
  });
}