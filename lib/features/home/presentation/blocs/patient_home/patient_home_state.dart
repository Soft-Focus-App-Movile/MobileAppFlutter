import '../../../../library/domain/models/content.dart';
import '../../../../library/domain/models/assignment.dart';
import '../../../../profiles/domain/models/psychologist_profile.dart';

abstract class PatientHomeState {}

class PatientHomeInitial extends PatientHomeState {}

class PatientHomeLoading extends PatientHomeState {}

class PatientHomeLoaded extends PatientHomeState {
  final RecommendationsState recommendationsState;
  final TherapistState therapistState;
  final AssignmentsState assignmentsState;

  PatientHomeLoaded({
    required this.recommendationsState,
    required this.therapistState,
    required this.assignmentsState,
  });

  PatientHomeLoaded copyWith({
    RecommendationsState? recommendationsState,
    TherapistState? therapistState,
    AssignmentsState? assignmentsState,
  }) {
    return PatientHomeLoaded(
      recommendationsState: recommendationsState ?? this.recommendationsState,
      therapistState: therapistState ?? this.therapistState,
      assignmentsState: assignmentsState ?? this.assignmentsState,
    );
  }
}

// Recommendations State
abstract class RecommendationsState {}

class RecommendationsLoading extends RecommendationsState {}

class RecommendationsSuccess extends RecommendationsState {
  final List<Content> recommendations;

  RecommendationsSuccess(this.recommendations);
}

class RecommendationsEmpty extends RecommendationsState {}

class RecommendationsError extends RecommendationsState {
  final String message;

  RecommendationsError(this.message);
}

// Therapist State
abstract class TherapistState {}

class TherapistLoading extends TherapistState {}

class TherapistSuccess extends TherapistState {
  final PsychologistProfile psychologist;
  final String? lastMessage;
  final String? lastMessageTime;

  TherapistSuccess({
    required this.psychologist,
    this.lastMessage,
    this.lastMessageTime,
  });
}

class NoTherapist extends TherapistState {}

class TherapistError extends TherapistState {
  final String message;

  TherapistError(this.message);
}

// Assignments State
abstract class AssignmentsState {}

class AssignmentsLoading extends AssignmentsState {}

class AssignmentsSuccess extends AssignmentsState {
  final List<Assignment> assignments;
  final int pendingCount;
  final int completedCount;

  AssignmentsSuccess({
    required this.assignments,
    required this.pendingCount,
    required this.completedCount,
  });
}

class AssignmentsError extends AssignmentsState {
  final String message;

  AssignmentsError(this.message);
}
