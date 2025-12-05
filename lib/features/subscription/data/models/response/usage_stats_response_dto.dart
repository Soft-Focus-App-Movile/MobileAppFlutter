import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/usage_stats.dart';

part 'usage_stats_response_dto.g.dart';

@JsonSerializable()
class FeatureUsageDto {
  final String featureType;
  final int currentUsage;
  final int? limit;
  final bool isUnlimited;
  final bool limitReached;
  final int? remaining;
  final String periodStart;
  final String periodEnd;
  final String? lastUsedAt;

  FeatureUsageDto({
    required this.featureType,
    required this.currentUsage,
    this.limit,
    required this.isUnlimited,
    required this.limitReached,
    this.remaining,
    required this.periodStart,
    required this.periodEnd,
    this.lastUsedAt,
  });

  factory FeatureUsageDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureUsageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureUsageDtoToJson(this);

  FeatureUsage toDomain() {
    return FeatureUsage(
      featureType: featureType,
      currentUsage: currentUsage,
      limit: limit,
      isUnlimited: isUnlimited,
      limitReached: limitReached,
      remaining: remaining,
      periodStart: periodStart,
      periodEnd: periodEnd,
      lastUsedAt: lastUsedAt,
    );
  }
}

@JsonSerializable()
class UsageStatsResponseDto {
  final String plan;
  final List<FeatureUsageDto> featureUsages;
  final String generatedAt;

  UsageStatsResponseDto({
    required this.plan,
    required this.featureUsages,
    required this.generatedAt,
  });

  factory UsageStatsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UsageStatsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UsageStatsResponseDtoToJson(this);

  UsageStats toDomain() {
    return UsageStats(
      plan: plan,
      featureUsages: featureUsages.map((e) => e.toDomain()).toList(),
      generatedAt: generatedAt,
    );
  }
}
