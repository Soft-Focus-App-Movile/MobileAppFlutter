import '../models/crisis_alert.dart';

abstract class CrisisRepository {
  Future<CrisisAlert> createCrisisAlert({
    double? latitude,
    double? longitude,
  });

  Future<List<CrisisAlert>> getPatientAlerts();

  Future<List<CrisisAlert>> getPsychologistAlerts({
    String? severity,
    String? status,
    int? limit,
  });

  Future<CrisisAlert> updateAlertStatus({
    required String alertId,
    required String status,
  });
}
