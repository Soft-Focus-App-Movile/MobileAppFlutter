import 'package:equatable/equatable.dart';
import '../../domain/entities/check_in.dart';
import '../../domain/entities/dashboard.dart';
import '../../domain/entities/emotional_calendar_entry.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object?> get props => [];
}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final TodayCheckIn? todayCheckIn;
  final CheckInHistory? checkInHistory;
  final EmotionalCalendar? emotionalCalendar;
  final TrackingDashboard? dashboard;

  const TrackingLoaded({
    this.todayCheckIn,
    this.checkInHistory,
    this.emotionalCalendar,
    this.dashboard,
  });

  @override
  List<Object?> get props => [
        todayCheckIn,
        checkInHistory,
        emotionalCalendar,
        dashboard,
      ];

  TrackingLoaded copyWith({
    TodayCheckIn? todayCheckIn,
    CheckInHistory? checkInHistory,
    EmotionalCalendar? emotionalCalendar,
    TrackingDashboard? dashboard,
  }) {
    return TrackingLoaded(
      todayCheckIn: todayCheckIn ?? this.todayCheckIn,
      checkInHistory: checkInHistory ?? this.checkInHistory,
      emotionalCalendar: emotionalCalendar ?? this.emotionalCalendar,
      dashboard: dashboard ?? this.dashboard,
    );
  }
}

class TrackingError extends TrackingState {
  final String message;

  const TrackingError(this.message);

  @override
  List<Object?> get props => [message];
}

// ============= CHECK-IN FORM STATES =============

class CheckInFormLoading extends TrackingState {}

class CheckInFormSuccess extends TrackingState {}

class CheckInFormError extends TrackingState {
  final String message;

  const CheckInFormError(this.message);

  @override
  List<Object?> get props => [message];
}

// ============= EMOTIONAL CALENDAR FORM STATES =============

class EmotionalCalendarFormLoading extends TrackingState {}

class EmotionalCalendarFormSuccess extends TrackingState {}

class EmotionalCalendarFormError extends TrackingState {
  final String message;

  const EmotionalCalendarFormError(this.message);

  @override
  List<Object?> get props => [message];
}