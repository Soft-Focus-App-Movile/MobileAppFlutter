import 'package:equatable/equatable.dart';
import 'check_in.dart';

// ============= DASHBOARD SUMMARY =============

class DashboardSummary extends Equatable {
  final bool hasTodayCheckIn;
  final CheckIn? todayCheckIn;
  final int totalCheckIns;
  final int totalEmotionalCalendarEntries;
  final double averageEmotionalLevel;
  final double averageEnergyLevel;
  final double averageMoodLevel;
  final List<String> mostCommonSymptoms;
  final List<String> mostUsedEmotionalTags;

  const DashboardSummary({
    required this.hasTodayCheckIn,
    this.todayCheckIn,
    required this.totalCheckIns,
    required this.totalEmotionalCalendarEntries,
    required this.averageEmotionalLevel,
    required this.averageEnergyLevel,
    required this.averageMoodLevel,
    required this.mostCommonSymptoms,
    required this.mostUsedEmotionalTags,
  });

  @override
  List<Object?> get props => [
        hasTodayCheckIn,
        todayCheckIn,
        totalCheckIns,
        totalEmotionalCalendarEntries,
        averageEmotionalLevel,
        averageEnergyLevel,
        averageMoodLevel,
        mostCommonSymptoms,
        mostUsedEmotionalTags,
      ];
}

// ============= DASHBOARD INSIGHTS =============

class DashboardInsights extends Equatable {
  final List<String> messages;

  const DashboardInsights({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];
}

// ============= TRACKING DASHBOARD =============

class TrackingDashboard extends Equatable {
  final DashboardSummary summary;
  final DashboardInsights insights;

  const TrackingDashboard({
    required this.summary,
    required this.insights,
  });

  @override
  List<Object?> get props => [summary, insights];
}