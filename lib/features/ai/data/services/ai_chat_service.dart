import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/chat_message_request_dto.dart';
import '../models/response/chat_message_response_dto.dart';
import '../models/response/ai_usage_stats_response_dto.dart';
import '../models/response/chat_history_response_dto.dart';
import '../models/response/session_messages_response_dto.dart';

/// Service for AI chat-related API calls
class AIChatService {
  final HttpClient _httpClient;

  AIChatService({HttpClient? httpClient}) : _httpClient = httpClient ?? HttpClient();

  /// Send a message to AI chat
  Future<ChatMessageResponseDto> sendMessage(ChatMessageRequestDto request) async {
    final response = await _httpClient.post(
      AIEndpoints.chatMessage,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return ChatMessageResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message: ${response.body}');
    }
  }

  /// Get AI usage statistics
  Future<AIUsageStatsResponseDto> getUsageStats() async {
    final response = await _httpClient.get(AIEndpoints.chatUsage);

    if (response.statusCode == 200) {
      return AIUsageStatsResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get usage stats: ${response.body}');
    }
  }

  /// Get chat sessions
  Future<ChatHistoryResponseDto> getChatSessions({int pageSize = 20}) async {
    final response = await _httpClient.get(
      '${AIEndpoints.chatSessions}?pageSize=$pageSize',
    );

    if (response.statusCode == 200) {
      return ChatHistoryResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get chat sessions: ${response.body}');
    }
  }

  /// Get messages from a specific session
  Future<SessionMessagesResponseDto> getSessionMessages(
    String sessionId, {
    int limit = 50,
  }) async {
    final endpoint = AIEndpoints.getChatSessionMessages(sessionId);
    final response = await _httpClient.get('$endpoint?limit=$limit');

    if (response.statusCode == 200) {
      return SessionMessagesResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get session messages: ${response.body}');
    }
  }
}
