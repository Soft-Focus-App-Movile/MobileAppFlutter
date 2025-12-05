import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../psychologist/data/remote/psychologist_service.dart';
import '../../../../therapy/data/services/therapy_service.dart';
import 'psychologist_home_event.dart';
import 'psychologist_home_state.dart';

class PsychologistHomeBloc
    extends Bloc<PsychologistHomeEvent, PsychologistHomeState> {
  final PsychologistService _psychologistService;
  final TherapyService _therapyService;

  PsychologistHomeBloc({
    required PsychologistService psychologistService,
    required TherapyService therapyService,
  })  : _psychologistService = psychologistService,
        _therapyService = therapyService,
        super(PsychologistHomeInitial()) {
    on<LoadPsychologistHomeData>(_onLoadPsychologistHomeData);
    on<RefreshPsychologistStats>(_onRefreshPsychologistStats);
    on<RefreshPatients>(_onRefreshPatients);
    on<RefreshAll>(_onRefreshAll);
    on<CopyInvitationCode>(_onCopyInvitationCode);
    on<ShareInvitationCode>(_onShareInvitationCode);
  }

  Future<void> _onLoadPsychologistHomeData(
    LoadPsychologistHomeData event,
    Emitter<PsychologistHomeState> emit,
  ) async {
    emit(PsychologistHomeLoading());

    try {
      // Load invitation code, stats, and patients in parallel
      final invitationCodeDto = await _psychologistService.getInvitationCode();
      final statsDto = await _psychologistService.getStats();
      final patientsDtoList = await _therapyService.getPatientDirectory();

      emit(PsychologistHomeLoaded(
        invitationCode: invitationCodeDto.toDomain(),
        stats: statsDto.toDomain(),
        patients: patientsDtoList.map((dto) => dto.toDomain()).toList(),
      ));
    } catch (e) {
      emit(PsychologistHomeError(e.toString()));
    }
  }

  Future<void> _onRefreshPsychologistStats(
    RefreshPsychologistStats event,
    Emitter<PsychologistHomeState> emit,
  ) async {
    if (state is PsychologistHomeLoaded) {
      final currentState = state as PsychologistHomeLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      try {
        final statsDto = await _psychologistService.getStats(
          fromDate: event.fromDate,
          toDate: event.toDate,
        );

        emit(currentState.copyWith(
          stats: statsDto.toDomain(),
          isRefreshing: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(
          isRefreshing: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<void> _onRefreshPatients(
    RefreshPatients event,
    Emitter<PsychologistHomeState> emit,
  ) async {
    if (state is PsychologistHomeLoaded) {
      final currentState = state as PsychologistHomeLoaded;

      try {
        final patientsDto = await _therapyService.getPatientDirectory();

        emit(currentState.copyWith(
          patients: patientsDto.map((dto) => dto.toDomain()).toList(),
        ));
      } catch (e) {
        emit(currentState.copyWith(
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<void> _onRefreshAll(
    RefreshAll event,
    Emitter<PsychologistHomeState> emit,
  ) async {
    if (state is PsychologistHomeLoaded) {
      final currentState = state as PsychologistHomeLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      try {
        final statsDto = await _psychologistService.getStats();
        final patientsDtoList = await _therapyService.getPatientDirectory();

        emit(currentState.copyWith(
          stats: statsDto.toDomain(),
          patients: patientsDtoList.map((dto) => dto.toDomain()).toList(),
          isRefreshing: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(
          isRefreshing: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<void> _onCopyInvitationCode(
    CopyInvitationCode event,
    Emitter<PsychologistHomeState> emit,
  ) async {
    // This will be handled by the UI layer with Clipboard
    emit(InvitationCodeCopied());
  }

  Future<void> _onShareInvitationCode(
    ShareInvitationCode event,
    Emitter<PsychologistHomeState> emit,
  ) async {
    // This will be handled by the UI layer with Share plugin
    emit(InvitationCodeShared());
  }
}
