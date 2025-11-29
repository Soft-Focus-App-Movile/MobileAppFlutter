import 'package:equatable/equatable.dart';

// ============= EMOTIONAL CALENDAR ENTRY =============

class EmotionalCalendarEntry extends Equatable {
  final String id;
  final String userId;
  final DateTime date;
  final String emotionalEmoji;
  final int moodLevel;
  final List<String> emotionalTags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EmotionalCalendarEntry({
    required this.id,
    required this.userId,
    required this.date,
    required this.emotionalEmoji,
    required this.moodLevel,
    required this.emotionalTags,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        date,
        emotionalEmoji,
        moodLevel,
        emotionalTags,
        createdAt,
        updatedAt,
      ];
}

// ============= EMOTIONAL CALENDAR =============

class EmotionalCalendar extends Equatable {
  final List<EmotionalCalendarEntry> entries;
  final int totalCount;
  final DateRange dateRange;

  const EmotionalCalendar({
    required this.entries,
    required this.totalCount,
    required this.dateRange,
  });

  @override
  List<Object?> get props => [entries, totalCount, dateRange];
}

// ============= DATE RANGE =============

class DateRange extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateRange({
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}