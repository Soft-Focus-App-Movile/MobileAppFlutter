abstract class PatientHomeEvent {}

class LoadPatientHomeData extends PatientHomeEvent {}

class RefreshRecommendations extends PatientHomeEvent {}

class RetryTherapist extends PatientHomeEvent {}

class RetryAssignments extends PatientHomeEvent {}