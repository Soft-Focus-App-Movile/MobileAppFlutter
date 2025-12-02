import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/connect_with_psychologist_request_dto.dart';
import '../models/response/my_relationship_response_dto.dart';
import '../models/response/connect_response_dto.dart';
import '../models/response/get_relationship_with_patient_response_dto.dart';
import '../models/response/patient_directory_item_response_dto.dart';
import '../models/request/send_chat_message_request_dto.dart';
import '../models/response/chat_message_response_dto.dart';

/// Service for therapy-related API calls (connection and my-relationship only)
class TherapyService {
  final HttpClient _httpClient;

  TherapyService({HttpClient? httpClient}) : _httpClient = httpClient ?? HttpClient();

  String? get authToken => _httpClient.token;

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

  /// Get psychologist's patient directory
  Future<List<PatientDirectoryItemResponseDto>> getPatientDirectory() async {
    // Endpoint: api/v1/therapy/patients
    final endpoint = 'therapy/patients'; 
    final response = await _httpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => PatientDirectoryItemResponseDto.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to get patient directory: ${response.body}');
    }
  }

  /// Get chat history
  Future<List<ChatMessageResponseDto>> getChatHistory(
      String relationshipId, {int page = 1, int size = 20}) async {
    final endpoint = 'chat/history?relationshipId=$relationshipId&page=$page&size=$size';
    final response = await _httpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ChatMessageResponseDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get chat history: ${response.body}');
    }
  }

  /// Get last received message
  Future<ChatMessageResponseDto?> getLastReceivedMessage() async {
    final endpoint = 'chat/last-received';
    final response = await _httpClient.get(endpoint);

    if (response.statusCode == 200) {
      return ChatMessageResponseDto.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to get last message: ${response.body}');
    }
  }

  /// Send a chat message
  Future<ChatMessageResponseDto> sendChatMessage(SendChatMessageRequestDto request) async {
    final response = await _httpClient.post(
      'chat/send',
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return ChatMessageResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message: ${response.body}');
    }
  }
}
