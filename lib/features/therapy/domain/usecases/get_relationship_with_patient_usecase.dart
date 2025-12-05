import '../../../../core/common/result.dart';
import '../repositories/therapy_repository.dart';

class GetRelationshipWithPatientUseCase {
  final TherapyRepository _repository;

  GetRelationshipWithPatientUseCase(this._repository);

  Future<Result<String>> call(String patientId) async {
    return await _repository.getRelationshipWithPatient(patientId);
  }
}