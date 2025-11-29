import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dashboard.dart';
import '../repositories/tracking_repository.dart';

class GetDashboardUseCase implements UseCase<TrackingDashboard, GetDashboardParams> {
  final TrackingRepository repository;

  GetDashboardUseCase(this.repository);

  @override
  Future<Either<Failure, TrackingDashboard>> call(GetDashboardParams params) async {
    return await repository.getDashboard(days: params.days);
  }
}

class GetDashboardParams {
  final int? days;

  GetDashboardParams({this.days});
}