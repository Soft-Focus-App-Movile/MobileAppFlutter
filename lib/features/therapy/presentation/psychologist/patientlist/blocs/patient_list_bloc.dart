// lib/features/therapy/presentation/psychologist/patientlist/blocs/patient_list_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_patient_directory_usecase.dart';
import '../../../../../../core/common/result.dart';
import 'patient_list_event.dart';
import 'patient_list_state.dart';

class PatientListBloc extends Bloc<PatientListEvent, PatientListState> {
  final GetPatientDirectoryUseCase _getPatientDirectoryUseCase;

  PatientListBloc({
    required GetPatientDirectoryUseCase getPatientDirectoryUseCase,
  })  : _getPatientDirectoryUseCase = getPatientDirectoryUseCase,
        super(PatientListInitial()) {
    on<LoadPatients>(_onLoadPatients);
    on<RefreshPatients>(_onRefreshPatients);
  }

  Future<void> _onLoadPatients(
    LoadPatients event,
    Emitter<PatientListState> emit,
  ) async {
    emit(PatientListLoading());
    await _loadPatients(emit);
  }

  Future<void> _onRefreshPatients(
    RefreshPatients event,
    Emitter<PatientListState> emit,
  ) async {
    // Para refresh, no mostramos loading si ya hay datos
    await _loadPatients(emit);
  }

  Future<void> _loadPatients(Emitter<PatientListState> emit) async {
    final result = await _getPatientDirectoryUseCase();

    // Pattern matching con switch expression
    switch (result) {
      case Success():
        emit(PatientListLoaded(result.data));
      case Error():
        emit(PatientListError(result.message));
    }
  }
}