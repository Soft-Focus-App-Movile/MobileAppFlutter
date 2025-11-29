import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_in.dart';
import '../repositories/tracking_repository.dart';

class GetCheckInsUseCase implements UseCase<CheckInHistory, GetCheckInsParams> {
  final TrackingRepository repository;

  GetCheckInsUseCase(this.repository);

  @override
  Future<Either<Failure, CheckInHistory>> call(GetCheckInsParams params) async {
    return await repository.getCheckIns(
      startDate: params.startDate,
      endDate: params.endDate,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetCheckInsParams {
  final String? startDate;
  final String? endDate;
  final int? pageNumber;
  final int? pageSize;

  GetCheckInsParams({
    this.startDate,
    this.endDate,
    this.pageNumber,
    this.pageSize,
  });
}