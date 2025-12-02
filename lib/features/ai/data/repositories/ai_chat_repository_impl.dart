import 'dart:convert';
import '../../../../core/common/result.dart';
import '../../domain/models/chat_response.dart';
import '../../domain/models/ai_usage_stats.dart';
import '../../domain/models/chat_session.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/repositories/ai_chat_repository.dart';
import '../services/ai_chat_service.dart';
import '../models/request/chat_message_request_dto.dart';

class AIChatRepositoryImpl implements AIChatRepository {
  final AIChatService _aiChatService;

  AIChatRepositoryImpl({required AIChatService service})
      : _aiChatService = service;

  @override
  Future<Result<ChatResponse>> sendMessage(
    String message,
    String? sessionId,
  ) async {
    try {
      final request = ChatMessageRequestDto(
        message: message,
        sessionId: sessionId,
      );
      final response = await _aiChatService.sendMessage(request);
      final chatMessage = response.toDomain();
      final chatResponse = ChatResponse(
        message: chatMessage,
        sessionId: response.sessionId,
      );
      return Success(chatResponse);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<AIUsageStats>> getUsageStats() async {
    try {
      final response = await _aiChatService.getUsageStats();
      final stats = response.toDomain();
      return Success(stats);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<List<ChatSession>>> getChatSessions({int pageSize = 20}) async {
    try {
      final response = await _aiChatService.getChatSessions(pageSize: pageSize);
      final sessions = response.sessions.map((dto) => dto.toDomain()).toList();
      return Success(sessions);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<List<ChatMessage>>> getSessionMessages(
    String sessionId, {
    int limit = 50,
  }) async {
    try {
      final response = await _aiChatService.getSessionMessages(
        sessionId,
        limit: limit,
      );
      final messages = response.messages.map((dto) => dto.toDomain()).toList();
      return Success(messages);
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
