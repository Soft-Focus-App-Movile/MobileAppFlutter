import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/data/local/local_user_data_source.dart';
import '../../../../../core/common/result.dart';
import '../../../../therapy/domain/repositories/therapy_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

/// BLoC for managing home screen state
/// Handles checking if GENERAL user has psychologist relationship (becomes "patient")
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TherapyRepository _therapyRepository;
  final LocalUserDataSource _localUserDataSource;

  HomeBloc({
    required TherapyRepository therapyRepository,
    required LocalUserDataSource localUserDataSource,
  })  : _therapyRepository = therapyRepository,
        _localUserDataSource = localUserDataSource,
        super(const HomeState()) {
    on<CheckPatientStatusRequested>(_onCheckPatientStatus);
    on<LoadHomeData>(_onLoadHomeData);
  }

  /// Checks if user has therapeutic relationship (psychologist assigned)
  /// - First checks local cache
  /// - If not cached, calls getMyRelationship API
  /// - Sets isPatient = true if relationship exists
  Future<void> _onCheckPatientStatus(
    CheckPatientStatusRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final hasLocalRelationship = await _localUserDataSource.hasTherapeuticRelationship();

      if (hasLocalRelationship) {
        emit(state.copyWith(
          isLoading: false,
          isPatient: true,
        ));
      } else {
        final result = await _therapyRepository.getMyRelationship();

        if (result is Success) {
          final relationship = (result as Success).data;
          final isPatient = relationship != null && relationship.isActive;

          if (isPatient) {
            await _localUserDataSource.saveTherapeuticRelationship(true);
          }

          emit(state.copyWith(
            isLoading: false,
            isPatient: isPatient,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            isPatient: false,
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isPatient: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // TODO: Implement home data loading logic
      // This will fetch user-specific data based on their type
      // (General, Patient, Psychologist, Admin)

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
