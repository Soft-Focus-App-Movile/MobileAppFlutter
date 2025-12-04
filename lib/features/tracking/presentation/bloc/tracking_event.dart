import 'package:equatable/equatable.dart';

abstract class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object?> get props => [];
}

// ============= LOAD DATA EVENTS =============

class LoadInitialDataEvent extends TrackingEvent {}

class RefreshDataEvent extends TrackingEvent {}

class LoadTodayCheckInEvent extends TrackingEvent {}

class LoadEmotionalCalendarEvent extends TrackingEvent {
  final String? startDate;
  final String? endDate;

  const LoadEmotionalCalendarEvent({
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

class LoadCheckInHistoryEvent extends TrackingEvent {
  final String? startDate;
  final String? endDate;
  final int? pageNumber;
  final int? pageSize;

  const LoadCheckInHistoryEvent({
    this.startDate,
    this.endDate,
    this.pageNumber,
    this.pageSize,
  });

  @override
  List<Object?> get props => [startDate, endDate, pageNumber, pageSize];
}

class LoadDashboardEvent extends TrackingEvent {
  final int? days;

  const LoadDashboardEvent({this.days});

  @override
  List<Object?> get props => [days];
}

// ============= CREATE EVENTS =============

class CreateCheckInEvent extends TrackingEvent {
  final int emotionalLevel;
  final int energyLevel;
  final String moodDescription;
  final int sleepHours;
  final List<String> symptoms;
  final String? notes;

  const CreateCheckInEvent({
    required this.emotionalLevel,
    required this.energyLevel,
    required this.moodDescription,
    required this.sleepHours,
    required this.symptoms,
    this.notes,
  });

  @override
  List<Object?> get props => [
        emotionalLevel,
        energyLevel,
        moodDescription,
        sleepHours,
        symptoms,
        notes,
      ];
}

class CreateEmotionalCalendarEntryEvent extends TrackingEvent {
  final String date;
  final String emotionalEmoji;
  final int moodLevel;
  final List<String> emotionalTags;

  const CreateEmotionalCalendarEntryEvent({
    required this.date,
    required this.emotionalEmoji,
    required this.moodLevel,
    required this.emotionalTags,
  });

  @override
  List<Object?> get props => [date, emotionalEmoji, moodLevel, emotionalTags];
}
