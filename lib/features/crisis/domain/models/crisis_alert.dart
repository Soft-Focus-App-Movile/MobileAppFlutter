class CrisisAlert {
  final String id;
  final String patientId;
  final String patientName;
  final String? patientPhotoUrl;
  final String psychologistId;
  final String severity;
  final String status;
  final String triggerSource;
  final String? triggerReason;
  final Location? location;
  final EmotionalContext? emotionalContext;
  final String? psychologistNotes;
  final String createdAt;
  final String? attendedAt;
  final String? resolvedAt;

  CrisisAlert({
    required this.id,
    required this.patientId,
    required this.patientName,
    this.patientPhotoUrl,
    required this.psychologistId,
    required this.severity,
    required this.status,
    required this.triggerSource,
    this.triggerReason,
    this.location,
    this.emotionalContext,
    this.psychologistNotes,
    required this.createdAt,
    this.attendedAt,
    this.resolvedAt,
  });
}

class Location {
  final double? latitude;
  final double? longitude;
  final String displayString;

  Location({
    this.latitude,
    this.longitude,
    required this.displayString,
  });
}

class EmotionalContext {
  final String? lastDetectedEmotion;
  final String? lastEmotionDetectedAt;
  final String? emotionSource;

  EmotionalContext({
    this.lastDetectedEmotion,
    this.lastEmotionDetectedAt,
    this.emotionSource,
  });
}
