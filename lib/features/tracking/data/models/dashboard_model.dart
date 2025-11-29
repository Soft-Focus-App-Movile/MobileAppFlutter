import 'package:freezed_annotation/freezed_annotation.dart';
import 'check_in_model.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

// ============= DASHBOARD SUMMARY =============

@freezed
class DashboardSummaryModel with _$DashboardSummaryModel {
  const factory DashboardSummaryModel({
    required bool hasTodayCheckIn,
    CheckInModel? todayCheckIn,
    required int totalCheckIns,
    required int totalEmotionalCalendarEntries,
    required double averageEmotionalLevel,
    required double averageEnergyLevel,
    required double averageMoodLevel,
    required List<String> mostCommonSymptoms,
    required List<String> mostUsedEmotionalTags,
  }) = _DashboardSummaryModel;

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryModelFromJson(json);
}

// ============= DASHBOARD INSIGHTS =============

@freezed
class DashboardInsightsModel with _$DashboardInsightsModel {
  const factory DashboardInsightsModel({
    required List<String> messages,
  }) = _DashboardInsightsModel;

  factory DashboardInsightsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardInsightsModelFromJson(json);
}

// ============= DASHBOARD DATA =============

@freezed
class DashboardDataModel with _$DashboardDataModel {
  const factory DashboardDataModel({
    required DashboardSummaryModel summary,
    required DashboardInsightsModel insights,
  }) = _DashboardDataModel;

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);
}

// ============= DASHBOARD API RESPONSE =============

@freezed
class DashboardApiResponse with _$DashboardApiResponse {
  const factory DashboardApiResponse({
    required bool success,
    required DashboardDataModel data,
    required String timestamp,
  }) = _DashboardApiResponse;

  factory DashboardApiResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardApiResponseFromJson(json);
}