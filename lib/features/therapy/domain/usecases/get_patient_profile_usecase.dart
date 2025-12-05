import '../../../../core/common/result.dart';
import '../models/patient_profile.dart';
import '../repositories/therapy_repository.dart';

class GetPatientProfileUseCase {
  final TherapyRepository _repository;

  GetPatientProfileUseCase(this._repository);

  Future<Result<PatientProfile>> call(String patientId) async {
    return await _repository.getPatientProfile(patientId);
  }
}