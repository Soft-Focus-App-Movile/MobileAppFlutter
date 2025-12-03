import '../../../domain/models/content.dart';

abstract class ContentDetailEvent {
  const ContentDetailEvent();
}

class LoadContentDetail extends ContentDetailEvent {
  final Content content;

  const LoadContentDetail({required this.content});
}

class ToggleContentFavorite extends ContentDetailEvent {
  const ToggleContentFavorite();
}

class AssignContentToPatient extends ContentDetailEvent {
  final String patientId;
  final String? notes;

  const AssignContentToPatient({
    required this.patientId,
    this.notes,
  });
}
