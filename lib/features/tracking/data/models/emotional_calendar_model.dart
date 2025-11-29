import 'package:freezed_annotation/freezed_annotation.dart';

part 'emotional_calendar_model.freezed.dart';
part 'emotional_calendar_model.g.dart';

// ============= EMOTIONAL CALENDAR REQUEST =============

@freezed
class CreateEmotionalCalendarRequest with _$CreateEmotionalCalendarRequest {
  const factory CreateEmotionalCalendarRequest({
    required String date,
    required String emotionalEmoji,
    required int moodLevel,
    required List<String> emotionalTags,
  }) = _CreateEmotionalCalendarRequest;

  factory CreateEmotionalCalendarRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateEmotionalCalendarRequestFromJson(json);
}

// ============= EMOTIONAL CALENDAR ENTRY RESPONSE =============

@freezed
class EmotionalCalendarEntryModel with _$EmotionalCalendarEntryModel {
  const factory EmotionalCalendarEntryModel({
    required String id,
    required String userId,
    required String date,
    required String emotionalEmoji,
    required int moodLevel,
    required List<String> emotionalTags,
    required String createdAt,
    required String updatedAt,
  }) = _EmotionalCalendarEntryModel;

  factory EmotionalCalendarEntryModel.fromJson(Map<String, dynamic> json) =>
      _$EmotionalCalendarEntryModelFromJson(json);
}

// ============= CREATE EMOTIONAL CALENDAR API RESPONSE =============

@freezed
class CreateEmotionalCalendarApiResponse with _$CreateEmotionalCalendarApiResponse {
  const factory CreateEmotionalCalendarApiResponse({
    required bool success,
    required String message,
    required EmotionalCalendarEntryModel data,
    required String timestamp,
  }) = _CreateEmotionalCalendarApiResponse;

  factory CreateEmotionalCalendarApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateEmotionalCalendarApiResponseFromJson(json);
}

// ============= DATE RANGE =============

@freezed
class DateRangeModel with _$DateRangeModel {
  const factory DateRangeModel({
    String? startDate,
    String? endDate,
  }) = _DateRangeModel;

  factory DateRangeModel.fromJson(Map<String, dynamic> json) =>
      _$DateRangeModelFromJson(json);
}

// ============= EMOTIONAL CALENDAR DATA RESPONSE =============

@freezed
class EmotionalCalendarDataModel with _$EmotionalCalendarDataModel {
  const factory EmotionalCalendarDataModel({
    required List<EmotionalCalendarEntryModel> entries,
    required int totalCount,
    required DateRangeModel dateRange,
  }) = _EmotionalCalendarDataModel;

  factory EmotionalCalendarDataModel.fromJson(Map<String, dynamic> json) =>
      _$EmotionalCalendarDataModelFromJson(json);
}

// ============= EMOTIONAL CALENDAR API RESPONSE =============

@freezed
class EmotionalCalendarApiResponse with _$EmotionalCalendarApiResponse {
  const factory EmotionalCalendarApiResponse({
    required bool success,
    required EmotionalCalendarDataModel data,
    required String timestamp,
  }) = _EmotionalCalendarApiResponse;

  factory EmotionalCalendarApiResponse.fromJson(Map<String, dynamic> json) =>
      _$EmotionalCalendarApiResponseFromJson(json);
}