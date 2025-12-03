import '../../../../../core/common/status.dart';
import '../../../domain/models/assignment.dart';

class AssignmentsState {
  final Status status;
  final List<Assignment> assignments;
  final int totalAssignments;
  final int completedCount;
  final int pendingCount;
  final String? message;

  const AssignmentsState({
    this.status = Status.initial,
    this.assignments = const [],
    this.totalAssignments = 0,
    this.completedCount = 0,
    this.pendingCount = 0,
    this.message,
  });

  AssignmentsState copyWith({
    Status? status,
    List<Assignment>? assignments,
    int? totalAssignments,
    int? completedCount,
    int? pendingCount,
    String? message,
  }) {
    return AssignmentsState(
      status: status ?? this.status,
      assignments: assignments ?? this.assignments,
      totalAssignments: totalAssignments ?? this.totalAssignments,
      completedCount: completedCount ?? this.completedCount,
      pendingCount: pendingCount ?? this.pendingCount,
      message: message ?? this.message,
    );
  }
}
