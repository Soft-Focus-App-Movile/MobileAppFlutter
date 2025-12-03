import 'content.dart';

class Assignment {
  final String id;
  final Content content;
  final String? psychologistId;
  final String? notes;
  final DateTime assignedDate;
  final bool isCompleted;
  final DateTime? completedDate;

  const Assignment({
    required this.id,
    required this.content,
    this.psychologistId,
    this.notes,
    required this.assignedDate,
    required this.isCompleted,
    this.completedDate,
  });
}
