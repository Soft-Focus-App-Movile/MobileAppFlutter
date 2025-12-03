import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

/// BLoC for managing home screen state
/// Handles checking if GENERAL user has psychologist relationship (becomes "patient")
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
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
      // TODO: Therapy team - Implement getMyRelationship API call
      // For now, default to false (user is GENERAL without psychologist)
      //
      // Implementation should:
      // 1. Check localUserDataSource.hasTherapeuticRelationship()
      // 2. If cached, use cached value
      // 3. If not cached, call getMyRelationshipUseCase()
      // 4. If relationship != null, isPatient = true
      // 5. Cache the result locally

      await Future.delayed(const Duration(milliseconds: 100));

      emit(state.copyWith(
        isLoading: false,
        isPatient: false,  // TODO: Replace with actual relationship check
      ));
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
