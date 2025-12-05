import '../../../../psychologist/domain/models/invitation_code.dart';
import '../../../../psychologist/domain/models/psychologist_stats.dart';
import '../../../../therapy/domain/models/patient_directory_item.dart';

abstract class PsychologistHomeState {}

class PsychologistHomeInitial extends PsychologistHomeState {}

class PsychologistHomeLoading extends PsychologistHomeState {}

class PsychologistHomeLoaded extends PsychologistHomeState {
  final InvitationCode? invitationCode;
  final PsychologistStats? stats;
  final List<PatientDirectoryItem> patients;
  final bool isRefreshing;
  final String? errorMessage;

  PsychologistHomeLoaded({
    this.invitationCode,
    this.stats,
    this.patients = const [],
    this.isRefreshing = false,
    this.errorMessage,
  });

  PsychologistHomeLoaded copyWith({
    InvitationCode? invitationCode,
    PsychologistStats? stats,
    List<PatientDirectoryItem>? patients,
    bool? isRefreshing,
    String? errorMessage,
  }) {
    return PsychologistHomeLoaded(
      invitationCode: invitationCode ?? this.invitationCode,
      stats: stats ?? this.stats,
      patients: patients ?? this.patients,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage,
    );
  }
}

class PsychologistHomeError extends PsychologistHomeState {
  final String message;

  PsychologistHomeError(this.message);
}

class InvitationCodeCopied extends PsychologistHomeState {}

class InvitationCodeShared extends PsychologistHomeState {}
