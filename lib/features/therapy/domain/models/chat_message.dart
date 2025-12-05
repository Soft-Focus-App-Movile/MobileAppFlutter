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

extension ChatMessageComparison on ChatMessage {
  bool isFromUser(String userId) {
    return senderId == userId;
  }
  
  ChatMessage copyWith({
    String? id,
    String? relationshipId,
    String? senderId,
    String? receiverId,
    String? content,
    DateTime? timestamp,
    bool? isRead,
    String? messageType,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      relationshipId: relationshipId ?? this.relationshipId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      messageType: messageType ?? this.messageType,
    );
  }
}