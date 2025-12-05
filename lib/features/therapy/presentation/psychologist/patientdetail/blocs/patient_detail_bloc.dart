import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../domain/usecases/get_patient_profile_usecase.dart';
import '../../../../domain/repositories/therapy_repository.dart';
import '../../../../../library/data/services/assignments_service.dart';
import '../../../../domain/usecases/get_patient_check_ins_usecase.dart';
import '../../../../../../core/common/result.dart';
import '../../../../../library/data/models/response/assignment_response_dto.dart';
import '../../../../../library/domain/models/assignment.dart';
import '../../../../../library/data/mappers/content_mapper.dart';
import 'patient_detail_event.dart';
import 'patient_detail_state.dart';

class PatientDetailBloc extends Bloc<PatientDetailEvent, PatientDetailState> {
  final GetPatientProfileUseCase _getPatientProfileUseCase;
  final GetPatientCheckInsUseCase _getPatientCheckInsUseCase;
  final TherapyRepository _therapyRepository;
  final AssignmentsService _assignmentsService;

  PatientDetailBloc({
    required GetPatientProfileUseCase getPatientProfileUseCase,
    required GetPatientCheckInsUseCase getPatientCheckInsUseCase,
    required TherapyRepository therapyRepository,
    required AssignmentsService assignmentsService,
  })  : _getPatientProfileUseCase = getPatientProfileUseCase,
        _getPatientCheckInsUseCase = getPatientCheckInsUseCase,
        _therapyRepository = therapyRepository,
        _assignmentsService = assignmentsService,
        super(const PatientDetailState()) {
    on<LoadPatientDetail>(_onLoadPatientDetail);
    on<LoadPatientCheckIns>(_onLoadPatientCheckIns);
    on<LoadPatientAssignments>(_onLoadPatientAssignments);
    on<RefreshPatientDetail>(_onRefreshPatientDetail);
  }

  Future<void> _onLoadPatientDetail(
    LoadPatientDetail event,
    Emitter<PatientDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getPatientProfileUseCase(event.patientId);

    switch (result) {
      case Success():
        final profile = result.data;
        final age = _calculateAge(profile.dateOfBirth);
        
        emit(state.copyWith(
          isLoading: false,
          profile: profile,
          profileError: null,
        ));
        
        // Cargar check-ins y assignments después de cargar el perfil
        add(LoadPatientCheckIns(event.patientId));
        add(LoadPatientAssignments(event.patientId));
        
      case Error():
        emit(state.copyWith(
          isLoading: false,
          profileError: result.message,
        ));
    }
  }

  Future<void> _onLoadPatientCheckIns(
    LoadPatientCheckIns event,
    Emitter<PatientDetailState> emit,
  ) async {
    emit(state.copyWith(checkInsLoading: true));

    // Cargar último check-in
    final lastCheckInResult = await _getPatientCheckInsUseCase(
      patientId: event.patientId,
      page: 1,
      pageSize: 1,
    );

    switch (lastCheckInResult) {
      case Success():
        final checkIns = lastCheckInResult.data;
        final lastCheckIn = checkIns.isNotEmpty ? checkIns.first : null;
        
        emit(state.copyWith(
          lastCheckIn: lastCheckIn,
          checkInsLoading: false,
          checkInsError: null,
        ));
        
      case Error():
        emit(state.copyWith(
          checkInsLoading: false,
          checkInsError: lastCheckInResult.message,
        ));
    }

    // Cargar datos de la semana para el gráfico
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    final weeklyResult = await _therapyRepository.getPatientCheckIns(
      patientId: event.patientId,
      startDate: DateFormat('yyyy-MM-dd').format(startOfWeek),
      endDate: DateFormat('yyyy-MM-dd').format(endOfWeek),
      page: 1,
      pageSize: 7,
    );

    switch (weeklyResult) {
      case Success():
        final checkIns = weeklyResult.data;
        final lineData = List<double>.filled(7, 0);
        
        for (final checkIn in checkIns) {
          final dayIndex = checkIn.completedAt.weekday - 1;
          if (dayIndex >= 0 && dayIndex < 7) {
            lineData[dayIndex] = checkIn.emotionalLevel.toDouble();
          }
        }
        
        final maxLevel = lineData.reduce((a, b) => a > b ? a : b);
        final columnData = List<double>.filled(7, 0);
        if (maxLevel > 0) {
          final maxIndex = lineData.indexOf(maxLevel);
          columnData[maxIndex] = maxLevel;
        }
        
        emit(state.copyWith(
          weeklyChartLineData: lineData,
          weeklyChartColumnData: columnData,
        ));
        
      case Error():
        // Mantener datos vacíos en caso de error
        break;
    }
  }

  Future<void> _onLoadPatientAssignments(
    LoadPatientAssignments event,
    Emitter<PatientDetailState> emit,
  ) async {
    emit(state.copyWith(assignmentsLoading: true));

    try {
      final response = await _assignmentsService.getPsychologistAssignments(
        patientId: event.patientId,
      );
      
      final List<Assignment> assignments = response.assignments
          .map((dto) => dto.toDomain())
          .toList();
      final pending = assignments.where((a) => !a.isCompleted).length;
      final completed = assignments.where((a) => a.isCompleted).length;
      
      emit(state.copyWith(
        assignmentsLoading: false,
        assignments: assignments,
        pendingCount: pending,
        completedCount: completed,
        assignmentsError: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        assignmentsLoading: false,
        assignmentsError: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshPatientDetail(
    RefreshPatientDetail event,
    Emitter<PatientDetailState> emit,
  ) async {
    add(LoadPatientDetail(event.patientId));
  }

  int _calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null) return 0; // Manejo de nulo
    
    try {
      final birthDate = DateTime.parse(dateOfBirth);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      
      return age;
    } catch (e) {
      return 0;
    }
  }
}

// --- EXTENSIÓN MAPPER ---
extension AssignmentDtoMapper on AssignmentResponseDto {
  Assignment toDomain() {
    return Assignment(
      id: assignmentId,
      content: ContentMapper.fromDto(content), 
      isCompleted: isCompleted,
      assignedDate: DateTime.parse(assignedAt),
      completedDate: completedAt != null ? DateTime.parse(completedAt!) : null,
      notes: notes,
      psychologistId: psychologistId, 
    );
  }
}