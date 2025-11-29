import 'package:equatable/equatable.dart';
import 'pagination.dart';

// ============= CHECK-IN ENTITY =============

class CheckIn extends Equatable {
  final String id;
  final String userId;
  final int emotionalLevel;
  final int energyLevel;
  final String moodDescription;
  final int sleepHours;
  final List<String> symptoms;
  final String? notes;
  final DateTime completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CheckIn({
    required this.id,
    required this.userId,
    required this.emotionalLevel,
    required this.energyLevel,
    required this.moodDescription,
    required this.sleepHours,
    required this.symptoms,
    this.notes,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        emotionalLevel,
        energyLevel,
        moodDescription,
        sleepHours,
        symptoms,
        notes,
        completedAt,
        createdAt,
        updatedAt,
      ];
}

// ============= CHECK-IN HISTORY =============

class CheckInHistory extends Equatable {
  final List<CheckIn> checkIns;
  final Pagination pagination;

  const CheckInHistory({
    required this.checkIns,
    required this.pagination,
  });

  @override
  List<Object?> get props => [checkIns, pagination];
}

// ============= TODAY CHECK-IN =============

class TodayCheckIn extends Equatable {
  final CheckIn? checkIn;
  final bool hasTodayCheckIn;

  const TodayCheckIn({
    this.checkIn,
    required this.hasTodayCheckIn,
  });

  @override
  List<Object?> get props => [checkIn, hasTodayCheckIn];
}