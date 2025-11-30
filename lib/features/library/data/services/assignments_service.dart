import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/assignment_request_dto.dart';
import '../models/response/assignments_response_dto.dart';
import '../models/response/assignment_completed_response_dto.dart';
import '../models/response/assignment_created_response_dto.dart';

/// Service for assignment management
class AssignmentsService {
  final HttpClient _httpClient;

  AssignmentsService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  // ============================================================
  // ENDPOINTS FOR PATIENTS
  // ============================================================

  /// Get assigned content for authenticated patient
  ///
  /// @param completed Optional filter by completion status (true/false)
  /// @return Object with list of assignments and statistics (total, pending, completed)
  Future<AssignmentsResponseDto> getAssignedContent({
    bool? completed,
  }) async {
    final queryParameters = <String, dynamic>{};

    if (completed != null) {
      queryParameters['completed'] = completed.toString();
    }

    final response = await _httpClient.get(
      LibraryEndpoints.assignedContent,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return AssignmentsResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get assigned content: ${response.body}');
    }
  }

  /// Mark assignment as completed
  ///
  /// @param assignmentId ID of assignment to complete
  /// @return Confirmation with completion date
  ///
  /// Note: Can only be completed once, and only by the assigned patient
  Future<AssignmentCompletedResponseDto> completeAssignment(
    String assignmentId,
  ) async {
    final response = await _httpClient.post(
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

  /// Assign content to one or more patients
  ///
  /// @param request Assignment data (patientIds, contentId, contentType, notes)
  /// @return IDs of created assignments
  ///
  /// Note: Only psychologists can use this endpoint
  /// Patients must belong to the authenticated psychologist
  Future<AssignmentCreatedResponseDto> assignContent(
    AssignmentRequestDto request,
  ) async {
    final response = await _httpClient.post(
      LibraryEndpoints.assignments,
      body: request.toJson(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return AssignmentCreatedResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to assign content: ${response.body}');
    }
  }

  /// Get all assignments created by authenticated psychologist
  ///
  /// @param patientId Optional filter by specific patient ID
  /// @return Object with list of assignments and statistics (total, pending, completed)
  ///
  /// Note: Only psychologists can use this endpoint
  Future<AssignmentsResponseDto> getPsychologistAssignments({
    String? patientId,
  }) async {
    final queryParameters = <String, dynamic>{};

    if (patientId != null) {
      queryParameters['patientId'] = patientId;
    }

    final response = await _httpClient.get(
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
