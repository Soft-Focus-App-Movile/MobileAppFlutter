import 'package:equatable/equatable.dart';

abstract class ConnectPsychologistEvent extends Equatable {
  const ConnectPsychologistEvent();

  @override
  List<Object?> get props => [];
}

class ConnectWithCodeRequested extends ConnectPsychologistEvent {
  final String connectionCode;

  const ConnectWithCodeRequested(this.connectionCode);

  @override
  List<Object?> get props => [connectionCode];
}

class ResetConnectionState extends ConnectPsychologistEvent {
  const ResetConnectionState();
}
