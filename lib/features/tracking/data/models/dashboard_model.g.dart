// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSummaryModelImpl _$$DashboardSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardSummaryModelImpl(
  hasTodayCheckIn: json['hasTodayCheckIn'] as bool,
  todayCheckIn: json['todayCheckIn'] == null
      ? null
      : CheckInModel.fromJson(json['todayCheckIn'] as Map<String, dynamic>),
  totalCheckIns: (json['totalCheckIns'] as num).toInt(),
  totalEmotionalCalendarEntries: (json['totalEmotionalCalendarEntries'] as num)
      .toInt(),
  averageEmotionalLevel: (json['averageEmotionalLevel'] as num).toDouble(),
  averageEnergyLevel: (json['averageEnergyLevel'] as num).toDouble(),
  averageMoodLevel: (json['averageMoodLevel'] as num).toDouble(),
  mostCommonSymptoms: (json['mostCommonSymptoms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  mostUsedEmotionalTags: (json['mostUsedEmotionalTags'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$DashboardSummaryModelImplToJson(
  _$DashboardSummaryModelImpl instance,
) => <String, dynamic>{
  'hasTodayCheckIn': instance.hasTodayCheckIn,
  'todayCheckIn': instance.todayCheckIn,
  'totalCheckIns': instance.totalCheckIns,
  'totalEmotionalCalendarEntries': instance.totalEmotionalCalendarEntries,
  'averageEmotionalLevel': instance.averageEmotionalLevel,
  'averageEnergyLevel': instance.averageEnergyLevel,
  'averageMoodLevel': instance.averageMoodLevel,
  'mostCommonSymptoms': instance.mostCommonSymptoms,
  'mostUsedEmotionalTags': instance.mostUsedEmotionalTags,
};

_$DashboardInsightsModelImpl _$$DashboardInsightsModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardInsightsModelImpl(
  messages: (json['messages'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$DashboardInsightsModelImplToJson(
  _$DashboardInsightsModelImpl instance,
) => <String, dynamic>{'messages': instance.messages};

_$DashboardDataModelImpl _$$DashboardDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardDataModelImpl(
  summary: DashboardSummaryModel.fromJson(
    json['summary'] as Map<String, dynamic>,
  ),
  insights: DashboardInsightsModel.fromJson(
    json['insights'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$DashboardDataModelImplToJson(
  _$DashboardDataModelImpl instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'insights': instance.insights,
};

_$DashboardApiResponseImpl _$$DashboardApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardApiResponseImpl(
  success: json['success'] as bool,
  data: DashboardDataModel.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] as String,
);

Map<String, dynamic> _$$DashboardApiResponseImplToJson(
  _$DashboardApiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'timestamp': instance.timestamp,
};
