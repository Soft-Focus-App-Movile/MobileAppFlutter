import '../../../domain/models/crisis_alert.dart';

abstract class CrisisAlertsState {
  final String? selectedSeverity;

  CrisisAlertsState({this.selectedSeverity});
}

class CrisisAlertsLoadingState extends CrisisAlertsState {
  CrisisAlertsLoadingState({String? selectedSeverity})
      : super(selectedSeverity: selectedSeverity);
}

class CrisisAlertsEmptyState extends CrisisAlertsState {
  CrisisAlertsEmptyState({String? selectedSeverity})
      : super(selectedSeverity: selectedSeverity);
}

class CrisisAlertsSuccessState extends CrisisAlertsState {
  final List<CrisisAlert> alerts;

  CrisisAlertsSuccessState({
    required this.alerts,
    String? selectedSeverity,
  }) : super(selectedSeverity: selectedSeverity);
}

class CrisisAlertsErrorState extends CrisisAlertsState {
  final String message;

  CrisisAlertsErrorState({
    required this.message,
    String? selectedSeverity,
  }) : super(selectedSeverity: selectedSeverity);
}
