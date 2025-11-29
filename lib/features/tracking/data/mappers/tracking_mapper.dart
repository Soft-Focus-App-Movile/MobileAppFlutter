import '../models/check_in_model.dart';
import '../models/emotional_calendar_model.dart';
import '../models/dashboard_model.dart';
import '../models/pagination_model.dart';
import '../../domain/entities/check_in.dart';
import '../../domain/entities/emotional_calendar_entry.dart';
import '../../domain/entities/dashboard.dart';
import '../../domain/entities/pagination.dart';

// ============= CHECK-IN MAPPERS =============

extension CheckInModelMapper on CheckInModel {
  CheckIn toDomain() {
    return CheckIn(
      id: id,
      userId: userId,
      emotionalLevel: emotionalLevel,
      energyLevel: energyLevel,
      moodDescription: moodDescription,
      sleepHours: sleepHours,
      symptoms: symptoms,
      notes: notes,
      completedAt: DateTime.parse(completedAt),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension CheckInsHistoryMapper on CheckInsHistoryApiResponse {
  CheckInHistory toDomain() {
    return CheckInHistory(
      checkIns: data.map((model) => model.toDomain()).toList(),
      pagination: pagination.toDomain(),
    );
  }
}

extension TodayCheckInMapper on TodayCheckInApiResponse {
  TodayCheckIn toDomain() {
    return TodayCheckIn(
      checkIn: data?.toDomain(),
      hasTodayCheckIn: hasTodayCheckIn,
    );
  }
}

// ============= PAGINATION MAPPER =============

extension PaginationModelMapper on PaginationModel {
  Pagination toDomain() {
    return Pagination(
      currentPage: currentPage,
      pageSize: pageSize,
      totalCount: totalCount,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
}

// ============= EMOTIONAL CALENDAR MAPPERS =============

extension EmotionalCalendarEntryModelMapper on EmotionalCalendarEntryModel {
  EmotionalCalendarEntry toDomain() {
    return EmotionalCalendarEntry(
      id: id,
      userId: userId,
      date: DateTime.parse(date),
      emotionalEmoji: emotionalEmoji,
      moodLevel: moodLevel,
      emotionalTags: emotionalTags,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension DateRangeModelMapper on DateRangeModel {
  DateRange toDomain() {
    return DateRange(
      startDate: startDate != null ? DateTime.parse(startDate!) : null,
      endDate: endDate != null ? DateTime.parse(endDate!) : null,
    );
  }
}

extension EmotionalCalendarMapper on EmotionalCalendarApiResponse {
  EmotionalCalendar toDomain() {
    return EmotionalCalendar(
      entries: data.entries.map((model) => model.toDomain()).toList(),
      totalCount: data.totalCount,
      dateRange: data.dateRange.toDomain(),
    );
  }
}

// ============= DASHBOARD MAPPERS =============

extension DashboardSummaryModelMapper on DashboardSummaryModel {
  DashboardSummary toDomain() {
    return DashboardSummary(
      hasTodayCheckIn: hasTodayCheckIn,
      todayCheckIn: todayCheckIn?.toDomain(),
      totalCheckIns: totalCheckIns,
      totalEmotionalCalendarEntries: totalEmotionalCalendarEntries,
      averageEmotionalLevel: averageEmotionalLevel,
      averageEnergyLevel: averageEnergyLevel,
      averageMoodLevel: averageMoodLevel,
      mostCommonSymptoms: mostCommonSymptoms,
      mostUsedEmotionalTags: mostUsedEmotionalTags,
    );
  }
}

extension DashboardInsightsModelMapper on DashboardInsightsModel {
  DashboardInsights toDomain() {
    return DashboardInsights(
      messages: messages,
    );
  }
}

extension DashboardMapper on DashboardApiResponse {
  TrackingDashboard toDomain() {
    return TrackingDashboard(
      summary: data.summary.toDomain(),
      insights: data.insights.toDomain(),
    );
  }
}
