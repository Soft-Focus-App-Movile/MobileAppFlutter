/// Events for HomeBloc
abstract class HomeEvent {
  const HomeEvent();
}

/// Event to load home data
class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

/// Event to refresh home data
class RefreshHomeData extends HomeEvent {
  const RefreshHomeData();
}

/// Event to check if user is a patient (has psychologist relationship)
class CheckPatientStatusRequested extends HomeEvent {
  const CheckPatientStatusRequested();
}
