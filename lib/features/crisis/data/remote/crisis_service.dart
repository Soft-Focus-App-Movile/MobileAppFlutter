import 'package:dio/dio.dart';
import '../models/request/create_crisis_alert_request_dto.dart';
import '../models/request/update_alert_status_request_dto.dart';
import '../models/response/crisis_alert_response_dto.dart';

class CrisisService {
  final Dio _dio;

  CrisisService(this._dio);

  Future<CrisisAlertResponseDto> createCrisisAlert(
    CreateCrisisAlertRequestDto request,
  ) async {
    final response = await _dio.post(
      'crisis/alert',
      data: request.toJson(),
    );
    return CrisisAlertResponseDto.fromJson(response.data);
  }

  Future<List<CrisisAlertResponseDto>> getPatientAlerts() async {
    final response = await _dio.get('crisis/alerts/patient');
    return (response.data as List)
        .map((json) => CrisisAlertResponseDto.fromJson(json))
        .toList();
  }

  Future<List<CrisisAlertResponseDto>> getPsychologistAlerts({
    String? severity,
    String? status,
    int? limit,
  }) async {
    final response = await _dio.get(
      'crisis/alerts',
      queryParameters: {
        if (severity != null) 'severity': severity,
        if (status != null) 'status': status,
        if (limit != null) 'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => CrisisAlertResponseDto.fromJson(json))
        .toList();
  }

  Future<CrisisAlertResponseDto> updateAlertStatus(
    String alertId,
    UpdateAlertStatusRequestDto request,
  ) async {
    final response = await _dio.put(
      'crisis/alerts/$alertId/status',
      data: request.toJson(),
    );
    return CrisisAlertResponseDto.fromJson(response.data);
  }
}
