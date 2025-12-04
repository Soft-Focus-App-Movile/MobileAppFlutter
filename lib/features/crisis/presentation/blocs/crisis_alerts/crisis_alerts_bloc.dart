import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/crisis_repository.dart';
import 'crisis_alerts_event.dart';
import 'crisis_alerts_state.dart';

class CrisisAlertsBloc extends Bloc<CrisisAlertsEvent, CrisisAlertsState> {
  final CrisisRepository crisisRepository;
  String? _currentSeverity;

  CrisisAlertsBloc({required this.crisisRepository})
      : super(CrisisAlertsLoadingState()) {
    on<LoadCrisisAlerts>(_onLoadAlerts);
    on<UpdateAlertStatus>(_onUpdateAlertStatus);
    on<RetryCrisisAlerts>(_onRetry);

    add(LoadCrisisAlerts());
  }

  Future<void> _onLoadAlerts(
    LoadCrisisAlerts event,
    Emitter<CrisisAlertsState> emit,
  ) async {
    emit(CrisisAlertsLoadingState(selectedSeverity: event.severity));
    _currentSeverity = event.severity;

    try {
      final alerts = await crisisRepository.getPsychologistAlerts(
        severity: event.severity,
      );

      if (alerts.isEmpty) {
        emit(CrisisAlertsEmptyState(selectedSeverity: event.severity));
      } else {
        emit(CrisisAlertsSuccessState(
          alerts: alerts,
          selectedSeverity: event.severity,
        ));
      }
    } catch (e) {
      emit(CrisisAlertsErrorState(
        message: e.toString(),
        selectedSeverity: event.severity,
      ));
    }
  }

  Future<void> _onUpdateAlertStatus(
    UpdateAlertStatus event,
    Emitter<CrisisAlertsState> emit,
  ) async {
    try {
      final nextStatus = _getNextStatus(event.currentStatus);
      await crisisRepository.updateAlertStatus(
        alertId: event.alertId,
        status: nextStatus,
      );
      add(LoadCrisisAlerts(severity: _currentSeverity));
    } catch (e) {
      emit(CrisisAlertsErrorState(
        message: e.toString(),
        selectedSeverity: _currentSeverity,
      ));
    }
  }

  void _onRetry(
    RetryCrisisAlerts event,
    Emitter<CrisisAlertsState> emit,
  ) {
    add(LoadCrisisAlerts(severity: _currentSeverity));
  }

  String _getNextStatus(String currentStatus) {
    switch (currentStatus.toUpperCase()) {
      case 'PENDING':
        return 'Attended';
      case 'ATTENDED':
        return 'Resolved';
      case 'RESOLVED':
        return 'Pending';
      default:
        return 'Pending';
    }
  }
}
