// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsageLimitsDto _$UsageLimitsDtoFromJson(Map<String, dynamic> json) =>
    UsageLimitsDto(
      aiChatMessagesPerDay: (json['aiChatMessagesPerDay'] as num?)?.toInt(),
      facialAnalysisPerWeek: (json['facialAnalysisPerWeek'] as num?)?.toInt(),
      contentRecommendationsPerWeek:
          (json['contentRecommendationsPerWeek'] as num?)?.toInt(),
      checkInsPerDay: (json['checkInsPerDay'] as num?)?.toInt(),
      maxPatientConnections: (json['maxPatientConnections'] as num?)?.toInt(),
      contentAssignmentsPerWeek: (json['contentAssignmentsPerWeek'] as num?)
          ?.toInt(),
    );

Map<String, dynamic> _$UsageLimitsDtoToJson(UsageLimitsDto instance) =>
    <String, dynamic>{
      'aiChatMessagesPerDay': instance.aiChatMessagesPerDay,
      'facialAnalysisPerWeek': instance.facialAnalysisPerWeek,
      'contentRecommendationsPerWeek': instance.contentRecommendationsPerWeek,
      'checkInsPerDay': instance.checkInsPerDay,
      'maxPatientConnections': instance.maxPatientConnections,
      'contentAssignmentsPerWeek': instance.contentAssignmentsPerWeek,
    };

SubscriptionResponseDto _$SubscriptionResponseDtoFromJson(
  Map<String, dynamic> json,
) => SubscriptionResponseDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userType: json['userType'] as String,
  plan: json['plan'] as String,
  status: json['status'] as String,
  currentPeriodStart: json['currentPeriodStart'] as String?,
  currentPeriodEnd: json['currentPeriodEnd'] as String?,
  cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool,
  cancelledAt: json['cancelledAt'] as String?,
  isActive: json['isActive'] as bool,
  usageLimits: UsageLimitsDto.fromJson(
    json['usageLimits'] as Map<String, dynamic>,
  ),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$SubscriptionResponseDtoToJson(
  SubscriptionResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userType': instance.userType,
  'plan': instance.plan,
  'status': instance.status,
  'currentPeriodStart': instance.currentPeriodStart,
  'currentPeriodEnd': instance.currentPeriodEnd,
  'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
  'cancelledAt': instance.cancelledAt,
  'isActive': instance.isActive,
  'usageLimits': instance.usageLimits,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
