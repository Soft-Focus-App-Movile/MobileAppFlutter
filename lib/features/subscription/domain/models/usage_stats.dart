class FeatureUsage {
  final String featureType;
  final int currentUsage;
  final int? limit;
  final bool isUnlimited;
  final bool limitReached;
  final int? remaining;
  final String periodStart;
  final String periodEnd;
  final String? lastUsedAt;

  FeatureUsage({
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
}

class UsageStats {
  final String plan;
  final List<FeatureUsage> featureUsages;
  final String generatedAt;

  UsageStats({
    required this.plan,
    required this.featureUsages,
    required this.generatedAt,
  });
}
