import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/models/ai_usage_stats.dart';

part 'ai_usage_stats_response_dto.g.dart';

@JsonSerializable()
class AIUsageStatsResponseDto {
  final int chatMessagesUsed;
  final int chatMessagesLimit;
  final int facialAnalysisUsed;
  final int facialAnalysisLimit;
  final int remainingMessages;
  final int remainingAnalyses;
  final String currentWeek;
  final String resetsAt;
  final String plan;

  const AIUsageStatsResponseDto({
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

  factory AIUsageStatsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AIUsageStatsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AIUsageStatsResponseDtoToJson(this);

  AIUsageStats toDomain() {
    return AIUsageStats(
      chatMessagesUsed: chatMessagesUsed,
      chatMessagesLimit: chatMessagesLimit,
      facialAnalysisUsed: facialAnalysisUsed,
      facialAnalysisLimit: facialAnalysisLimit,
      remainingMessages: remainingMessages,
      remainingAnalyses: remainingAnalyses,
      currentWeek: currentWeek,
      resetsAt: _parseTimestamp(resetsAt),
      plan: plan,
    );
  }

  DateTime _parseTimestamp(String timestamp) {
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return DateTime.now().add(const Duration(days: 7));
    }
  }
}
