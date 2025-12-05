abstract class PatientDetailEvent {}

class LoadPatientDetail extends PatientDetailEvent {
  final String patientId;
  
  LoadPatientDetail(this.patientId);
}

class LoadPatientCheckIns extends PatientDetailEvent {
  final String patientId;
  
  LoadPatientCheckIns(this.patientId);
}

class LoadPatientAssignments extends PatientDetailEvent {
  final String patientId;
  
  LoadPatientAssignments(this.patientId);
}

class RefreshPatientDetail extends PatientDetailEvent {
  final String patientId;
  
  RefreshPatientDetail(this.patientId);
}