// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_stats_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureUsageDto _$FeatureUsageDtoFromJson(Map<String, dynamic> json) =>
    FeatureUsageDto(
      featureType: json['featureType'] as String,
      currentUsage: (json['currentUsage'] as num).toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      isUnlimited: json['isUnlimited'] as bool,
      limitReached: json['limitReached'] as bool,
      remaining: (json['remaining'] as num?)?.toInt(),
      periodStart: json['periodStart'] as String,
      periodEnd: json['periodEnd'] as String,
      lastUsedAt: json['lastUsedAt'] as String?,
    );

Map<String, dynamic> _$FeatureUsageDtoToJson(FeatureUsageDto instance) =>
    <String, dynamic>{
      'featureType': instance.featureType,
      'currentUsage': instance.currentUsage,
      'limit': instance.limit,
      'isUnlimited': instance.isUnlimited,
      'limitReached': instance.limitReached,
      'remaining': instance.remaining,
      'periodStart': instance.periodStart,
      'periodEnd': instance.periodEnd,
      'lastUsedAt': instance.lastUsedAt,
    };

UsageStatsResponseDto _$UsageStatsResponseDtoFromJson(
  Map<String, dynamic> json,
) => UsageStatsResponseDto(
  plan: json['plan'] as String,
  featureUsages: (json['featureUsages'] as List<dynamic>)
      .map((e) => FeatureUsageDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  generatedAt: json['generatedAt'] as String,
);

Map<String, dynamic> _$UsageStatsResponseDtoToJson(
  UsageStatsResponseDto instance,
) => <String, dynamic>{
  'plan': instance.plan,
  'featureUsages': instance.featureUsages,
  'generatedAt': instance.generatedAt,
};
