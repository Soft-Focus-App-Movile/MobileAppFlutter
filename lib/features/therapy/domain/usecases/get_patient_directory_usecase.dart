import '../../../../core/common/result.dart';
import '../models/patient_directory_item.dart';
import '../repositories/therapy_repository.dart';

class GetPatientDirectoryUseCase {
  final TherapyRepository _repository;

  GetPatientDirectoryUseCase(this._repository);

  Future<Result<List<PatientDirectoryItem>>> call() async {
    return await _repository.getPatientDirectory();
  }
}