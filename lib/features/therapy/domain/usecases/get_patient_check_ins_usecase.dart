import '../../../../core/common/result.dart';
import '../../../tracking/domain/entities/check_in.dart';
import '../repositories/therapy_repository.dart';

class GetPatientCheckInsUseCase {
  final TherapyRepository _repository;

  GetPatientCheckInsUseCase(this._repository);

  Future<Result<List<CheckIn>>> call({
    required String patientId,
    int page = 1,
    int pageSize = 10,
    String? startDate,
    String? endDate,
  }) async {
    return await _repository.getPatientCheckIns(
      patientId: patientId,
      page: page,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
    );
  }
}