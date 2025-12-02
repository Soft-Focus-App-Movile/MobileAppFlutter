import 'dart:convert';
import '../../../../core/common/result.dart';
import '../../domain/models/therapeutic_relationship.dart';
import '../../domain/repositories/therapy_repository.dart';
import '../services/therapy_service.dart';
import '../models/request/connect_with_psychologist_request_dto.dart';

class TherapyRepositoryImpl implements TherapyRepository {
  final TherapyService _therapyService;

  TherapyRepositoryImpl({required TherapyService service})
      : _therapyService = service;

  @override
  Future<Result<TherapeuticRelationship?>> getMyRelationship() async {
    try {
      final response = await _therapyService.getMyRelationship();

      if (response.hasRelationship && response.relationship != null) {
        final relationship = response.relationship!.toDomain();
        return Success(relationship);
      } else {
        return Success(null);
      }
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<String>> getRelationshipWithPatient(String patientId) async {
    try {
      final response = await _therapyService.getRelationshipWithPatient(patientId);
      return Success(response.relationshipId);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<String>> connectWithPsychologist(String connectionCode) async {
    try {
      final request = ConnectWithPsychologistRequestDto(
        connectionCode: connectionCode,
      );
      final response = await _therapyService.connectWithPsychologist(request);
      return Success(response.relationshipId);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  /// Extract error message from exception
  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();

    // Try to parse JSON error response
    try {
      if (errorString.contains('{') && errorString.contains('}')) {
        final jsonStart = errorString.indexOf('{');
        final jsonEnd = errorString.lastIndexOf('}') + 1;
        final jsonString = errorString.substring(jsonStart, jsonEnd);
        final jsonMap = jsonDecode(jsonString);

        if (jsonMap['message'] != null) {
          return jsonMap['message'];
        }
      }
    } catch (e) {
      // If JSON parsing fails, return the original error
    }

    // Extract message after "Exception: " or "failed: "
    if (errorString.contains('Exception: ')) {
      return errorString.split('Exception: ').last;
    } else if (errorString.contains('failed: ')) {
      return errorString.split('failed: ').last;
    }

    return 'An error occurred: $errorString';
  }
}
