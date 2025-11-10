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
