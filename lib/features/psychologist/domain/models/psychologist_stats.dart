class PsychologistStats {
  final int activePatientsCount;
  final int pendingCrisisAlerts;
  final int todayCheckInsCompleted;
  final double averageAdherenceRate;
  final int newPatientsThisMonth;
  final double averageEmotionalLevel;
  final String statsGeneratedAt;

  PsychologistStats({
    required this.activePatientsCount,
    required this.pendingCrisisAlerts,
    required this.todayCheckInsCompleted,
    required this.averageAdherenceRate,
    required this.newPatientsThisMonth,
    required this.averageEmotionalLevel,
    required this.statsGeneratedAt,
  });
}
