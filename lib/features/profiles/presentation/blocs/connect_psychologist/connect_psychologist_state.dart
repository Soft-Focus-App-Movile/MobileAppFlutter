import 'package:equatable/equatable.dart';

abstract class ConnectPsychologistState extends Equatable {
  const ConnectPsychologistState();

  @override
  List<Object?> get props => [];
}

class ConnectPsychologistInitial extends ConnectPsychologistState {
  const ConnectPsychologistInitial();
}

class ConnectPsychologistLoading extends ConnectPsychologistState {
  const ConnectPsychologistLoading();
}

class ConnectPsychologistSuccess extends ConnectPsychologistState {
  final String relationshipId;

  const ConnectPsychologistSuccess(this.relationshipId);

  @override
  List<Object?> get props => [relationshipId];
}

class ConnectPsychologistError extends ConnectPsychologistState {
  final String message;

  const ConnectPsychologistError(this.message);

  @override
  List<Object?> get props => [message];
}
