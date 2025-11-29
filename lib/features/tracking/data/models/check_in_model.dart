import 'package:freezed_annotation/freezed_annotation.dart';
import 'pagination_model.dart';

part 'check_in_model.freezed.dart';
part 'check_in_model.g.dart';

// ============= CHECK-IN REQUEST =============

@freezed
class CreateCheckInRequest with _$CreateCheckInRequest {
  const factory CreateCheckInRequest({
    required int emotionalLevel,
    required int energyLevel,
    required String moodDescription,
    required int sleepHours,
    required List<String> symptoms,
    String? notes,
  }) = _CreateCheckInRequest;

  factory CreateCheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckInRequestFromJson(json);
}

// ============= CHECK-IN RESPONSE =============

@freezed
class CheckInModel with _$CheckInModel {
  const factory CheckInModel({
    required String id,
    required String userId,
    required int emotionalLevel,
    required int energyLevel,
    required String moodDescription,
    required int sleepHours,
    required List<String> symptoms,
    String? notes,
    required String completedAt,
    required String createdAt,
    required String updatedAt,
  }) = _CheckInModel;

  factory CheckInModel.fromJson(Map<String, dynamic> json) =>
      _$CheckInModelFromJson(json);
}

// ============= CREATE CHECK-IN API RESPONSE =============

@freezed
class CreateCheckInApiResponse with _$CreateCheckInApiResponse {
  const factory CreateCheckInApiResponse({
    required bool success,
    required String message,
    required CheckInModel data,
    required String timestamp,
  }) = _CreateCheckInApiResponse;

  factory CreateCheckInApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckInApiResponseFromJson(json);
}

// ============= CHECK-INS HISTORY API RESPONSE =============

@freezed
class CheckInsHistoryApiResponse with _$CheckInsHistoryApiResponse {
  const factory CheckInsHistoryApiResponse({
    required bool success,
    required List<CheckInModel> data,
    required PaginationModel pagination,
    required String timestamp,
  }) = _CheckInsHistoryApiResponse;

  factory CheckInsHistoryApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInsHistoryApiResponseFromJson(json);
}

// ============= TODAY CHECK-IN API RESPONSE =============

@freezed
class TodayCheckInApiResponse with _$TodayCheckInApiResponse {
  const factory TodayCheckInApiResponse({
    required bool success,
    CheckInModel? data,
    required bool hasTodayCheckIn,
    required String timestamp,
  }) = _TodayCheckInApiResponse;

  factory TodayCheckInApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TodayCheckInApiResponseFromJson(json);
}