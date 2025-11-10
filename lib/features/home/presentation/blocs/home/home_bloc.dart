import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

/// BLoC for managing home screen state
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      // TODO: Implement home data loading logic
      // This will fetch user-specific data based on their type
      // (General, Patient, Psychologist, Admin)

      emit(const HomeLoaded());
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
