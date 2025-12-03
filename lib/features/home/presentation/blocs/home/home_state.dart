import 'package:equatable/equatable.dart';

/// State for HomeBloc
/// Contains flags to determine home screen behavior
class HomeState extends Equatable {
  final bool isLoading;
  final bool isPatient;  // true if GENERAL user has psychologist relationship
  final String? error;

  const HomeState({
    this.isLoading = true,
    this.isPatient = false,
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isPatient,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isPatient: isPatient ?? this.isPatient,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isPatient, error];
}
