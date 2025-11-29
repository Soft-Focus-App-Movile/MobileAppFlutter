import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_in.dart';
import '../repositories/tracking_repository.dart';

class GetTodayCheckInUseCase implements UseCase<TodayCheckIn, NoParams> {
  final TrackingRepository repository;

  GetTodayCheckInUseCase(this.repository);

  @override
  Future<Either<Failure, TodayCheckIn>> call(NoParams params) async {
    return await repository.getTodayCheckIn();
  }
}