class ChatSession {
  final String sessionId;
  final DateTime startedAt;
  final DateTime lastMessageAt;
  final int messageCount;
  final bool isActive;
  final String? lastMessagePreview;

  const ChatSession({
    required this.sessionId,
    required this.startedAt,
    required this.lastMessageAt,
    required this.messageCount,
    required this.isActive,
    this.lastMessagePreview,
  });
}
