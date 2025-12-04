abstract class CrisisAlertsEvent {}

class LoadCrisisAlerts extends CrisisAlertsEvent {
  final String? severity;

  LoadCrisisAlerts({this.severity});
}

class UpdateAlertStatus extends CrisisAlertsEvent {
  final String alertId;
  final String currentStatus;

  UpdateAlertStatus({
    required this.alertId,
    required this.currentStatus,
  });
}

class RetryCrisisAlerts extends CrisisAlertsEvent {}
