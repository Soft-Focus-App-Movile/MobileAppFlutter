class TherapeuticRelationship {
  final String id;
  final String psychologistId;
  final String patientId;
  final String startDate;
  final String status;
  final bool isActive;
  final int sessionCount;

  const TherapeuticRelationship({
    required this.id,
    required this.psychologistId,
    required this.patientId,
    required this.startDate,
    required this.status,
    required this.isActive,
    required this.sessionCount,
  });
}
