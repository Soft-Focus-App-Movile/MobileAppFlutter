import '../../../domain/models/crisis_alert.dart';

abstract class CrisisAlertsState {
  final String? selectedSeverity;

  CrisisAlertsState({this.selectedSeverity});
}

class CrisisAlertsLoadingState extends CrisisAlertsState {
  CrisisAlertsLoadingState({super.selectedSeverity});
}

class CrisisAlertsEmptyState extends CrisisAlertsState {
  CrisisAlertsEmptyState({super.selectedSeverity});
}

class CrisisAlertsSuccessState extends CrisisAlertsState {
  final List<CrisisAlert> alerts;

  CrisisAlertsSuccessState({
    required this.alerts,
    super.selectedSeverity,
  });
}

class CrisisAlertsErrorState extends CrisisAlertsState {
  final String message;

  CrisisAlertsErrorState({
    required this.message,
    super.selectedSeverity,
  });
}
