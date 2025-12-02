class PatientDirectoryItem {
  final String id;
  final String psychologistId;
  final String patientId;
  final String patientName;
  final int age;
  final String profilePhotoUrl;
  final String status;
  final DateTime startDate;
  final int sessionCount;
  final DateTime? lastSessionDate;

  const PatientDirectoryItem({
    required this.id,
    required this.psychologistId,
    required this.patientId,
    required this.patientName,
    required this.age,
    required this.profilePhotoUrl,
    required this.status,
    required this.startDate,
    required this.sessionCount,
    this.lastSessionDate,
  });
}