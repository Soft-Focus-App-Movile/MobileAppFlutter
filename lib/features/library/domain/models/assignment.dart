import 'content.dart';

class Assignment {
  final String id;
  final Content content;
  final String psychologistId;
  final String psychologistName;
  final String? instructions;
  final DateTime assignedDate;
  final bool isCompleted;
  final DateTime? completedDate;

  const Assignment({
    required this.id,
    required this.content,
    required this.psychologistId,
    required this.psychologistName,
    this.instructions,
    required this.assignedDate,
    required this.isCompleted,
    this.completedDate,
  });
}
