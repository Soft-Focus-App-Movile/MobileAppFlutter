class ChatMessage {
  final String id;
  final String relationshipId;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final String messageType;

  const ChatMessage({
    required this.id,
    required this.relationshipId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
    this.messageType = 'text',
  });
}