enum SubscriptionPlan {
  basic,
  pro;

  static SubscriptionPlan fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pro':
        return SubscriptionPlan.pro;
      case 'basic':
      default:
        return SubscriptionPlan.basic;
    }
  }

  String toApiString() {
    switch (this) {
      case SubscriptionPlan.basic:
        return 'BASIC';
      case SubscriptionPlan.pro:
        return 'PRO';
    }
  }
}

enum SubscriptionStatus {
  active,
  cancelled,
  pastDue,
  trialing;

  static SubscriptionStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return SubscriptionStatus.active;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      case 'past_due':
        return SubscriptionStatus.pastDue;
      case 'trialing':
        return SubscriptionStatus.trialing;
      default:
        return SubscriptionStatus.active;
    }
  }
}

class UsageLimits {
  final int? aiChatMessagesPerDay;
  final int? facialAnalysisPerWeek;
  final int? contentRecommendationsPerWeek;
  final int? checkInsPerDay;
  final int? maxPatientConnections;
  final int? contentAssignmentsPerWeek;

  UsageLimits({
    this.aiChatMessagesPerDay,
    this.facialAnalysisPerWeek,
    this.contentRecommendationsPerWeek,
    this.checkInsPerDay,
    this.maxPatientConnections,
    this.contentAssignmentsPerWeek,
  });
}

class Subscription {
  final String id;
  final String userId;
  final String userType;
  final SubscriptionPlan plan;
  final SubscriptionStatus status;
  final String? currentPeriodStart;
  final String? currentPeriodEnd;
  final bool cancelAtPeriodEnd;
  final String? cancelledAt;
  final bool isActive;
  final UsageLimits usageLimits;
  final String createdAt;
  final String updatedAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.userType,
    required this.plan,
    required this.status,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    required this.cancelAtPeriodEnd,
    this.cancelledAt,
    required this.isActive,
    required this.usageLimits,
    required this.createdAt,
    required this.updatedAt,
  });
}
