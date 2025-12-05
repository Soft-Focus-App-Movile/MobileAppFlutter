// lib/features/therapy/presentation/psychologist/patientdetail/blocs/patient_chat_event.dart
import '../../../../domain/models/chat_message.dart';

abstract class PatientChatEvent {}

class InitializePatientChat extends PatientChatEvent {
  final String patientId;
  final String patientName;
  final String? patientProfileUrl;

  InitializePatientChat({
    required this.patientId,
    required this.patientName,
    this.patientProfileUrl,
  });
}

class LoadChatHistory extends PatientChatEvent {}

class SendChatMessage extends PatientChatEvent {
  final String patientId;
  final String content;

  SendChatMessage({
    required this.patientId,
    required this.content,
  });
}

class ReceiveNewMessage extends PatientChatEvent {
  final ChatMessage message;

  ReceiveNewMessage({required this.message});
}