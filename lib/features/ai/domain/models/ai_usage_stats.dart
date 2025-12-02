class AIUsageStats {
  final int chatMessagesUsed;
  final int chatMessagesLimit;
  final int facialAnalysisUsed;
  final int facialAnalysisLimit;
  final int remainingMessages;
  final int remainingAnalyses;
  final String currentWeek;
  final DateTime resetsAt;
  final String plan;

  const AIUsageStats({
    required this.chatMessagesUsed,
    required this.chatMessagesLimit,
    required this.facialAnalysisUsed,
    required this.facialAnalysisLimit,
    required this.remainingMessages,
    required this.remainingAnalyses,
    required this.currentWeek,
    required this.resetsAt,
    required this.plan,
  });
}
