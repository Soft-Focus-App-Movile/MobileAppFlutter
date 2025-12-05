import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/subscription.dart';

part 'subscription_response_dto.g.dart';

@JsonSerializable()
class UsageLimitsDto {
  final int? aiChatMessagesPerDay;
  final int? facialAnalysisPerWeek;
  final int? contentRecommendationsPerWeek;
  final int? checkInsPerDay;
  final int? maxPatientConnections;
  final int? contentAssignmentsPerWeek;

  UsageLimitsDto({
    this.aiChatMessagesPerDay,
    this.facialAnalysisPerWeek,
    this.contentRecommendationsPerWeek,
    this.checkInsPerDay,
    this.maxPatientConnections,
    this.contentAssignmentsPerWeek,
  });

  factory UsageLimitsDto.fromJson(Map<String, dynamic> json) =>
      _$UsageLimitsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UsageLimitsDtoToJson(this);

  UsageLimits toDomain() {
    return UsageLimits(
      aiChatMessagesPerDay: aiChatMessagesPerDay,
      facialAnalysisPerWeek: facialAnalysisPerWeek,
      contentRecommendationsPerWeek: contentRecommendationsPerWeek,
      checkInsPerDay: checkInsPerDay,
      maxPatientConnections: maxPatientConnections,
      contentAssignmentsPerWeek: contentAssignmentsPerWeek,
    );
  }
}

@JsonSerializable()
class SubscriptionResponseDto {
  final String id;
  final String userId;
  final String userType;
  final String plan;
  final String status;
  final String? currentPeriodStart;
  final String? currentPeriodEnd;
  final bool cancelAtPeriodEnd;
  final String? cancelledAt;
  final bool isActive;
  final UsageLimitsDto usageLimits;
  final String createdAt;
  final String updatedAt;

  SubscriptionResponseDto({
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

  factory SubscriptionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResponseDtoToJson(this);

  Subscription toDomain() {
    return Subscription(
      id: id,
      userId: userId,
      userType: userType,
      plan: SubscriptionPlan.fromString(plan),
      status: SubscriptionStatus.fromString(status),
      currentPeriodStart: currentPeriodStart,
      currentPeriodEnd: currentPeriodEnd,
      cancelAtPeriodEnd: cancelAtPeriodEnd,
      cancelledAt: cancelledAt,
      isActive: isActive,
      usageLimits: usageLimits.toDomain(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
