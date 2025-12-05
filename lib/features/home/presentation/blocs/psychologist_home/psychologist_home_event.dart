abstract class PsychologistHomeEvent {}

class LoadPsychologistHomeData extends PsychologistHomeEvent {}

class RefreshPsychologistStats extends PsychologistHomeEvent {
  final String? fromDate;
  final String? toDate;

  RefreshPsychologistStats({this.fromDate, this.toDate});
}

class RefreshPatients extends PsychologistHomeEvent {}

class RefreshAll extends PsychologistHomeEvent {}

class CopyInvitationCode extends PsychologistHomeEvent {}

class ShareInvitationCode extends PsychologistHomeEvent {}
