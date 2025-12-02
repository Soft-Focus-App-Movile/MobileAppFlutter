// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_usage_stats_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIUsageStatsResponseDto _$AIUsageStatsResponseDtoFromJson(
  Map<String, dynamic> json,
) => AIUsageStatsResponseDto(
  chatMessagesUsed: (json['chatMessagesUsed'] as num).toInt(),
  chatMessagesLimit: (json['chatMessagesLimit'] as num).toInt(),
  facialAnalysisUsed: (json['facialAnalysisUsed'] as num).toInt(),
  facialAnalysisLimit: (json['facialAnalysisLimit'] as num).toInt(),
  remainingMessages: (json['remainingMessages'] as num).toInt(),
  remainingAnalyses: (json['remainingAnalyses'] as num).toInt(),
  currentWeek: json['currentWeek'] as String,
  resetsAt: json['resetsAt'] as String,
  plan: json['plan'] as String,
);

Map<String, dynamic> _$AIUsageStatsResponseDtoToJson(
  AIUsageStatsResponseDto instance,
) => <String, dynamic>{
  'chatMessagesUsed': instance.chatMessagesUsed,
  'chatMessagesLimit': instance.chatMessagesLimit,
  'facialAnalysisUsed': instance.facialAnalysisUsed,
  'facialAnalysisLimit': instance.facialAnalysisLimit,
  'remainingMessages': instance.remainingMessages,
  'remainingAnalyses': instance.remainingAnalyses,
  'currentWeek': instance.currentWeek,
  'resetsAt': instance.resetsAt,
  'plan': instance.plan,
};
