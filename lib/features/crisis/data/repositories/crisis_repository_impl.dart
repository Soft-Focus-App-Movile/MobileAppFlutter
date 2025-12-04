import '../../domain/models/crisis_alert.dart';
import '../../domain/repositories/crisis_repository.dart';
import '../models/request/create_crisis_alert_request_dto.dart';
import '../models/request/update_alert_status_request_dto.dart';
import '../remote/crisis_service.dart';

class CrisisRepositoryImpl implements CrisisRepository {
  final CrisisService _crisisService;

  CrisisRepositoryImpl(this._crisisService);

  @override
  Future<CrisisAlert> createCrisisAlert({
    double? latitude,
    double? longitude,
  }) async {
    try {
      final request = CreateCrisisAlertRequestDto(
        latitude: latitude,
        longitude: longitude,
      );
      final response = await _crisisService.createCrisisAlert(request);
      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CrisisAlert>> getPatientAlerts() async {
    try {
      final response = await _crisisService.getPatientAlerts();
      return response.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CrisisAlert>> getPsychologistAlerts({
    String? severity,
    String? status,
    int? limit,
  }) async {
    try {
      final response = await _crisisService.getPsychologistAlerts(
        severity: severity,
        status: status,
        limit: limit,
      );
      return response.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CrisisAlert> updateAlertStatus({
    required String alertId,
    required String status,
  }) async {
    try {
      final request = UpdateAlertStatusRequestDto(status: status);
      final response = await _crisisService.updateAlertStatus(alertId, request);
      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }
}
