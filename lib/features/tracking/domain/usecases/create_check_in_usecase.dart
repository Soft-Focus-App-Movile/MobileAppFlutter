import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_in.dart';
import '../repositories/tracking_repository.dart';

class CreateCheckInUseCase implements UseCase<CheckIn, CreateCheckInParams> {
  final TrackingRepository repository;

  CreateCheckInUseCase(this.repository);

  @override
  Future<Either<Failure, CheckIn>> call(CreateCheckInParams params) async {
    return await repository.createCheckIn(
      emotionalLevel: params.emotionalLevel,
      energyLevel: params.energyLevel,
      moodDescription: params.moodDescription,
      sleepHours: params.sleepHours,
      symptoms: params.symptoms,
      notes: params.notes,
    );
  }
}

class CreateCheckInParams {
  final int emotionalLevel;
  final int energyLevel;
  final String moodDescription;
  final int sleepHours;
  final List<String> symptoms;
  final String? notes;

  CreateCheckInParams({
    required this.emotionalLevel,
    required this.energyLevel,
    required this.moodDescription,
    required this.sleepHours,
    required this.symptoms,
    this.notes,
  });
}