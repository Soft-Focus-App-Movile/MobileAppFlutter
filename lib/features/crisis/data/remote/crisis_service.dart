import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../models/request/create_crisis_alert_request_dto.dart';
import '../models/request/update_alert_status_request_dto.dart';
import '../models/response/crisis_alert_response_dto.dart';

class CrisisService {
  final HttpClient _httpClient;

  CrisisService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<CrisisAlertResponseDto> createCrisisAlert(
    CreateCrisisAlertRequestDto request,
  ) async {
    final response = await _httpClient.post(
      'crisis/alert',
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CrisisAlertResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear alerta de crisis: ${response.body}');
    }
  }

  Future<List<CrisisAlertResponseDto>> getPatientAlerts() async {
    final response = await _httpClient.get('crisis/alerts/patient');
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((json) => CrisisAlertResponseDto.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener alertas del paciente: ${response.body}');
    }
  }

  Future<List<CrisisAlertResponseDto>> getPsychologistAlerts({
    String? severity,
    String? status,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (severity != null) queryParams['severity'] = severity;
    if (status != null) queryParams['status'] = status;
    if (limit != null) queryParams['limit'] = limit.toString();

    String url = 'crisis/alerts';
    if (queryParams.isNotEmpty) {
      url += '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    }

    final response = await _httpClient.get(url);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((json) => CrisisAlertResponseDto.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener alertas del psicólogo: ${response.body}');
    }
  }

  Future<CrisisAlertResponseDto> updateAlertStatus(
    String alertId,
    UpdateAlertStatusRequestDto request,
  ) async {
    final response = await _httpClient.put(
      'crisis/alerts/$alertId/status',
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      return CrisisAlertResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar estado de alerta: ${response.body}');
    }
  }
}
