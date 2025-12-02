import '../../../../core/common/result.dart';
import '../models/therapeutic_relationship.dart';

abstract class TherapyRepository {
  Future<Result<TherapeuticRelationship?>> getMyRelationship();
  Future<Result<String>> getRelationshipWithPatient(String patientId);
  Future<Result<String>> connectWithPsychologist(String connectionCode);
}
