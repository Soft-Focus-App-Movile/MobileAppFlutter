import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/connect_with_psychologist_request_dto.dart';
import '../models/response/my_relationship_response_dto.dart';
import '../models/response/connect_response_dto.dart';
import '../models/response/get_relationship_with_patient_response_dto.dart';

/// Service for therapy-related API calls (connection and my-relationship only)
class TherapyService {
  final HttpClient _httpClient;

  TherapyService({HttpClient? httpClient}) : _httpClient = httpClient ?? HttpClient();

  /// Get my therapeutic relationship (patient perspective)
  Future<MyRelationshipResponseDto> getMyRelationship() async {
    final response = await _httpClient.get(TherapyEndpoints.myRelationship);

    if (response.statusCode == 200) {
      return MyRelationshipResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get my relationship: ${response.body}');
    }
  }

  /// Get relationship with a specific patient (psychologist perspective)
  Future<GetRelationshipWithPatientResponseDto> getRelationshipWithPatient(
    String patientId,
  ) async {
    final endpoint = 'therapy/relationship-with/$patientId';
    final response = await _httpClient.get(endpoint);

    if (response.statusCode == 200) {
      return GetRelationshipWithPatientResponseDto.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to get relationship with patient: ${response.body}');
    }
  }

  /// Connect with a psychologist using a connection code
  Future<ConnectResponseDto> connectWithPsychologist(
    ConnectWithPsychologistRequestDto request,
  ) async {
    final response = await _httpClient.post(
      TherapyEndpoints.connect,
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ConnectResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to connect with psychologist: ${response.body}');
    }
  }
}
