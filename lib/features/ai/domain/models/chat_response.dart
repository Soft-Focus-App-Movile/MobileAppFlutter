import 'chat_message.dart';

class ChatResponse {
  final ChatMessage message;
  final String sessionId;

  const ChatResponse({
    required this.message,
    required this.sessionId,
  });
}
