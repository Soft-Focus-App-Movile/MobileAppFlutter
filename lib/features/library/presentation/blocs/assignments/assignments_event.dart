abstract class AssignmentsEvent {
  const AssignmentsEvent();
}

class LoadAssignments extends AssignmentsEvent {
  const LoadAssignments();
}

class CompleteAssignment extends AssignmentsEvent {
  final String assignmentId;

  const CompleteAssignment({required this.assignmentId});
}
