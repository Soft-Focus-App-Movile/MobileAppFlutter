import 'package:equatable/equatable.dart';

abstract class VerifyPsychologistEvent extends Equatable {
  const VerifyPsychologistEvent();

  @override
  List<Object?> get props => [];
}

class LoadPsychologistDetail extends VerifyPsychologistEvent {
  final String userId;

  const LoadPsychologistDetail(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateNotes extends VerifyPsychologistEvent {
  final String notes;

  const UpdateNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}

class ApprovePsychologist extends VerifyPsychologistEvent {
  const ApprovePsychologist();
}

class RejectPsychologist extends VerifyPsychologistEvent {
  const RejectPsychologist();
}

class ClearError extends VerifyPsychologistEvent {
  const ClearError();
}

class ResetVerificationSuccess extends VerifyPsychologistEvent {
  const ResetVerificationSuccess();
}
