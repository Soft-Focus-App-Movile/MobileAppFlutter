import '../../../../core/common/result.dart';
import '../models/chat_response.dart';
import '../models/ai_usage_stats.dart';
import '../models/chat_session.dart';
import '../models/chat_message.dart';

abstract class AIChatRepository {
  Future<Result<ChatResponse>> sendMessage(String message, String? sessionId);
  Future<Result<AIUsageStats>> getUsageStats();
  Future<Result<List<ChatSession>>> getChatSessions({int pageSize = 20});
  Future<Result<List<ChatMessage>>> getSessionMessages(String sessionId, {int limit = 50});
}
