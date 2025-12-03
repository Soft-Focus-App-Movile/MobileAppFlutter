import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../auth/data/local/user_session.dart';
import '../models/request/assignment_request_dto.dart';
import '../models/response/assignments_response_dto.dart';
import '../models/response/assignment_completed_response_dto.dart';
import '../models/response/assignment_created_response_dto.dart';

class AssignmentsService {
  final UserSession _userSession = UserSession();

  Future<HttpClient> _getAuthenticatedClient() async {
    final user = await _userSession.getUser();
    return HttpClient(token: user?.token);
  }

  // ============================================================
  // ENDPOINTS FOR PATIENTS
  // ============================================================

  Future<AssignmentsResponseDto> getAssignedContent({
    bool? completed,
  }) async {
    final httpClient = await _getAuthenticatedClient();
    final queryParameters = <String, dynamic>{};

    if (completed != null) {
      queryParameters['completed'] = completed.toString();
    }

    final response = await httpClient.get(
      LibraryEndpoints.assignedContent,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return AssignmentsResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get assigned content: ${response.body}');
    }
  }

  Future<AssignmentCompletedResponseDto> completeAssignment(
    String assignmentId,
  ) async {
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.post(
      LibraryEndpoints.completeAssignmentById(assignmentId),
    );

    if (response.statusCode == 200) {
      return AssignmentCompletedResponseDto.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to complete assignment: ${response.body}');
    }
  }

  // ============================================================
  // ENDPOINTS FOR PSYCHOLOGISTS
  // ============================================================

  Future<AssignmentCreatedResponseDto> assignContent(
    AssignmentRequestDto request,
  ) async {
    final httpClient = await _getAuthenticatedClient();
    final response = await httpClient.post(
      LibraryEndpoints.assignments,
      body: request.toJson(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return AssignmentCreatedResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to assign content: ${response.body}');
    }
  }

  Future<AssignmentsResponseDto> getPsychologistAssignments({
    String? patientId,
  }) async {
    final httpClient = await _getAuthenticatedClient();
    final queryParameters = <String, dynamic>{};

    if (patientId != null) {
      queryParameters['patientId'] = patientId;
    }

    final response = await httpClient.get(
      LibraryEndpoints.psychologistAssignments,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return AssignmentsResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to get psychologist assignments: ${response.body}');
    }
  }
}
