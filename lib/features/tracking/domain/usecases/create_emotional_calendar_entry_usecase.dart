import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/emotional_calendar_entry.dart';
import '../repositories/tracking_repository.dart';

class CreateEmotionalCalendarEntryUseCase
    implements UseCase<EmotionalCalendarEntry, CreateEmotionalCalendarEntryParams> {
  final TrackingRepository repository;

  CreateEmotionalCalendarEntryUseCase(this.repository);

  @override
  Future<Either<Failure, EmotionalCalendarEntry>> call(
    CreateEmotionalCalendarEntryParams params,
  ) async {
    return await repository.createEmotionalCalendarEntry(
      date: params.date,
      emotionalEmoji: params.emotionalEmoji,
      moodLevel: params.moodLevel,
      emotionalTags: params.emotionalTags,
    );
  }
}

class CreateEmotionalCalendarEntryParams {
  final String date;
  final String emotionalEmoji;
  final int moodLevel;
  final List<String> emotionalTags;

  CreateEmotionalCalendarEntryParams({
    required this.date,
    required this.emotionalEmoji,
    required this.moodLevel,
    required this.emotionalTags,
  });
}