// lib/features/therapy/presentation/psychologist/patientdetail/blocs/patient_chat_state.dart
import 'package:equatable/equatable.dart';
import '../../../../domain/models/chat_message.dart';

class PatientChatState extends Equatable {
  final bool isLoading;
  final String patientName;
  final String? patientProfileUrl;
  final List<ChatMessage> messages;
  final String? error;

  const PatientChatState({
    this.isLoading = true,
    this.patientName = 'Cargando...',
    this.patientProfileUrl,
    this.messages = const [],
    this.error,
  });

  PatientChatState copyWith({
    bool? isLoading,
    String? patientName,
    String? patientProfileUrl,
    List<ChatMessage>? messages,
    String? error,
  }) {
    return PatientChatState(
      isLoading: isLoading ?? this.isLoading,
      patientName: patientName ?? this.patientName,
      patientProfileUrl: patientProfileUrl ?? this.patientProfileUrl,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        patientName,
        patientProfileUrl,
        messages,
        error,
      ];
}